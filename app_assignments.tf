resource "okta_group_rule" "neobank_iam_admin_users_rule" {
  name              = "Assign IAM Admin to Neobank"
  status            = "ACTIVE"
  group_assignments = [okta_group.neobank_it_iam_users.id]

  expression_type  = "urn:okta:expression:1.0"
  expression_value = "String.stringContains(user.department,\"IT\")"
}