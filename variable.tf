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