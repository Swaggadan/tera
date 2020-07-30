# Configure the Vultr Provider
provider "vultr" {
  api_key = var.api_key
  rate_limit = 700
  retry_limit = 3
}

variable "api_key" {
  type        = string
  description = "API Key"
}