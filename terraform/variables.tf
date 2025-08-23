variable "yc_token" {
  description = "Yandex Cloud IAM Token"
  type        = string
  sensitive   = true  
}

variable "cloud_id" {
  description = "Yandex Cloud Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "container_name" {
  description = "Name of serverless container"
  default     = "my-serverless-container" #TODO: change this to your container name
}

# TODO: test url 
variable "container_image" {
  description = "Docker image for serverless container"
  default     = "cr.yandex/crp-example/my-app:latest" # TODO: change this to your image
}
