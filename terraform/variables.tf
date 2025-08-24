variable "yc_token" {
  description = "Yandex Cloud IAM Token"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.yc_token) > 0
    error_message = "yc_token must not be empty"
  }
}

variable "organization_id" {
  description = "Yandex Cloud Organization ID"
  type        = string
  default     = "bpflh1nomhlsgkpkqdgk"
  validation {
    condition     = length(var.organization_id) > 0
    error_message = "organization_id must not be empty"
  }
}

variable "billing_account_id" {
  description = "Yandex Cloud Billing Account ID"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.billing_account_id) > 0
    error_message = "billing_account_id must not be empty"
  }
}

variable "cloud_name" {
  description = "Yandex Cloud name for your application"
  type        = string
  default     = "prj-webaot-example" # You can change this to your cloud name
  validation {
    condition     = length(var.cloud_name) > 0
    error_message = "cloud_name must not be empty"
  }
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "webaot"
  validation {
    condition     = length(var.app_name) > 0
    error_message = "app_name must not be empty"
  }
}

variable "environments" {
  description = "Map of environments to create with their configurations"
  type = map(object({
    description = string
    # You can add other environment-specific settings.
  }))
  default = {
    production = {
      description = "Production environment"
    }
    staging = {
      description = "Staging environment"
    }
  }
}
