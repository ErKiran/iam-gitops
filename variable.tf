variable "okta_org_name" {
  description = "The name of the Okta organization."
  type        = string
}
variable "okta_base_url" {
  description = "The base URL of the Okta organization."
  type        = string
  default     = "okta.com"
}

variable "okta_api_token" {
  description = "The API token for authenticating with the Okta API."
  type        = string
  sensitive   = true
}

variable "saml_acs_url" {
  type        = string
  description = "ACS url for the neobank application for the single sign on"
}

variable "saml_entity_id" {
  type        = string
  description = "Neobank Entity ID"
}