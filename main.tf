terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 6.10.0"
    }
  }
}

provider "okta" {
  org_name  = var.okta_org_name
  base_url  = var.okta_base_url
  api_token = var.okta_api_token
}

resource "okta_group" "neobank_finance_users" {
  name        = "neobank_finance_users"
  description = "Groups exclusive for finance users of neobank"
}

data "okta_app" "neobank" {
  label = "Neobank"
}

resource "okta_app_group_assignment" "finance_users_to_neobank" {
  app_id   = data.okta_app.neobank.id
  group_id = okta_group.neobank_finance_users.id

}