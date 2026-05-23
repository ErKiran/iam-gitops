resource "okta_app_group_assignment" "finance_users_to_neobank" {
  app_id   = data.okta_app.neobank.id
  group_id = okta_group.neobank_finance_users.id
}

resource "okta_group_rule" "neobank_iam_admin_users_rule" {
  name              = "Assign IAM Admin  users to the neobank admin groups"
  status            = "ACTIVE"
  group_assignments = [okta_group.neobank_iam_users.id]

  expression_type  = "urn:okta:expression:1.0"
  expression_value = "String.stringContains(user.department,\"IT\")"
}