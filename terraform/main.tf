resource "yandex_resourcemanager_cloud" "app_cloud" {
  name            = var.cloud_name
  description     = "Cloud for hosting your application"
  organization_id = var.organization_id
}

resource "yandex_resourcemanager_folder" "production" {
  cloud_id    = yandex_resourcemanager_cloud.app_cloud.id
  name        = "env-production"
  description = "Folder for production environment"
}

resource "yandex_resourcemanager_folder" "staging" {
  cloud_id    = yandex_resourcemanager_cloud.app_cloud.id
  name        = "env-staging"
  description = "Folder for staging environment"
}

resource "yandex_billing_cloud_binding" "binding" {
  billing_account_id = var.billing_account_id
  cloud_id           = yandex_resourcemanager_cloud.app_cloud.id
}

