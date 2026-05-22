resource "okta_app_group_assignment" "finance_users_to_neobank" {
  app_id   = data.okta_app.neobank.id
  group_id = okta_group.neobank_finance_users.id
}