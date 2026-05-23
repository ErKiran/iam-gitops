resource "okta_group" "neobank_finance_users" {
  name        = "Apps-neobank_finance_users"
  description = "Groups exclusive for finance users of neobank"
}

resource "okta_group" "neobank_iam_users" {
  name        = "Apps-neobank_iam_users"
  description = "Groups exclusive for IT Admins of neobank"
}