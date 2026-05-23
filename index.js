const express=  require("express");

const app = express();
app.use(express.json());

const {
  GITHUB_TOKEN,
  GITHUB_OWNER,
  GITHUB_REPO,
  GITHUB_WORKFLOW_FILE,
  SLACK_WEBHOOK_URL
} = process.env;

async function sendSlackMessage(text) {
  if (!SLACK_WEBHOOK_URL) {
    console.log("SLACK_WEBHOOK_URL is not configured");
    return;
  }

  const response = await fetch(SLACK_WEBHOOK_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ text })
  });

  if (!response.ok) {
    const errorText = await response.text();
    console.error("Failed to send Slack message:", errorText);
  }
}

// Okta verification endpoint
app.get("/okta/events", (req, res) => {
  const challenge = req.header("x-okta-verification-challenge");

  return res.json({
    verification: challenge
  });
});

// Okta event delivery endpoint
app.post("/okta/events", async (req, res) => {
  // Respond fast so Okta does not retry
  res.status(200).send("OK");

  const events = req.body?.data?.events || [];

  const interestingEvents = events.filter(event =>
    event.eventType?.includes("group") ||
    event.eventType?.includes("policy") ||
    event.eventType?.includes("application")
  );

  if (interestingEvents.length === 0) {
    return;
  }

  const firstEvent = interestingEvents[0];

  const eventType = firstEvent.eventType || "unknown";
  const actor =
    firstEvent.actor?.alternateId ||
    firstEvent.actor?.displayName ||
    "unknown actor";

  const target =
    firstEvent.target?.[0]?.displayName ||
    firstEvent.target?.[0]?.alternateId ||
    "unknown target";

  await sendSlackMessage(
    `Okta IAM Change Detected

Event: ${eventType}
Actor: ${actor}
Target: ${target}

A Terraform drift detection workflow is being triggered.

Note: This does not mean drift is confirmed yet. Terraform plan will verify whether Okta no longer matches the approved GitOps state.`
  );

  const githubResponse = await fetch(
    `https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/actions/workflows/${GITHUB_WORKFLOW_FILE}/dispatches`,
    {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${GITHUB_TOKEN}`,
        "Accept": "application/vnd.github+json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        ref: "main",
        inputs: {
          reason: "Okta change event detected",
          event_type: eventType
        }
      })
    }
  );

  if (!githubResponse.ok) {
    const errorText = await githubResponse.text();

    await sendSlackMessage(
      `Okta IAM Change Detected, But Drift Workflow Failed To Start

Event: ${eventType}
Actor: ${actor}
Target: ${target}

GitHub workflow dispatch failed.

Error:
${errorText}`
    );

    console.error("Failed to trigger GitHub Actions:", errorText);
    return;
  }

  await sendSlackMessage(
    `Terraform Drift Check Started

Event: ${eventType}
Actor: ${actor}
Target: ${target}

GitHub Actions workflow has been triggered successfully.`
  );
});

app.listen(3005, () => {
  console.log("Okta drift receiver running on port 3005");
});