resource "okta_app_group_assignments" "tellers_to_neobank_gitops" {
  app_id   = okta_app_saml.neobank_gitOps.id
  group {
    id = okta_group.neobank_teller_group.id
  }

}
