resource "okta_group_rule" "neobank_admins_users_rule" {
  name              = "Assign admin users to the neobank admin groups"
  status            = "ACTIVE"
  group_assignments = [okta_group.neobank_iam_it_users.id]

  expression_type  = "urn:okta:expression:1.0"
  expression_value = "String.stringContains(user.department,\"IT\")"
}

resource "okta_group_rule" "neobank_teller_users_rule" {
  name              = "Assign finance users to the neobank teller groups"
  status            = "ACTIVE"
  group_assignments = [okta_group.neobank_teller_group.id]

  expression_type  = "urn:okta:expression:1.0"
  expression_value = "String.stringContains(user.department,\"Finance\")"
}