variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  validation {
    condition     = length(var.cloud_id) > 0
    error_message = "cloud_id must not be empty"
  }
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
  validation {
    condition     = length(var.environment_name) > 0
    error_message = "environment_name must not be empty"
  }
}

variable "environment_description" {
  description = "Description of the environment"
  type        = string
  default     = ""
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
