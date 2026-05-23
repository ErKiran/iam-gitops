resource "okta_group" "neobank_iam_it_users" {
  name        = "Apps-neobank_iam_it_users"
  description = "Groups exclusive for IT Admins of neobank"
}
resource "okta_group" "neobank_teller_group" {
  name        = "Apps-neobank-tellers"
  description = "This groups is exclusively for the tellers users who helps customers in neobank app"
}
