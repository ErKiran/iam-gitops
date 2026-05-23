data "okta_app" "neobank" {
  label = "Neobank"
}

resource "okta_app_saml" "neobank_gitOps" {
  label                    = "Neobank Application - Managed by Tf"
  sso_url                  = var.saml_acs_url
  recipient                = var.saml_acs_url
  destination              = var.saml_acs_url
  audience                 = var.saml_entity_id
  subject_name_id_template = "$${user.email}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = false
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
}