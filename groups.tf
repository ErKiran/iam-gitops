resource "okta_group" "neobank_iam_it_users" {
  name        = "Apps-neobank_iam_it_users"
  description = "Groups exclusive for IT Admins of neobank"
}