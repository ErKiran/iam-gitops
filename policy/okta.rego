package okta.guardrails


# Enforce approved Okta group prefixes
deny contains msg if {
  resource := input.resource_changes[_]
  resource.type == "okta_group"

  name := resource.change.after.name

  not valid_group_prefix(name)

  msg := sprintf("Blocked: Okta group name must start with Users-, Apps-, Roles-, or Admin-. Found: %s", [name])
}

valid_group_prefix(name) if {
  startswith(name, "Users-")
}

valid_group_prefix(name) if {
  startswith(name, "Apps-")
}

valid_group_prefix(name) if {
  startswith(name, "Roles-")
}

valid_group_prefix(name) if {
  startswith(name, "Admin-")
}