output "cloud_id" {
  description = "ID of the created cloud"
  value       = yandex_resourcemanager_cloud.app_cloud.id
}

output "folder_ids" {
  description = "Map of folder names to their IDs"
  value = {
    production = yandex_resourcemanager_folder.production.id
    staging    = yandex_resourcemanager_folder.staging.id
  }
}

# IDs service accounts for CI/CD
output "cicd_production_sa_id" {
  value = yandex_iam_service_account.cicd_production.id
}

output "cicd_staging_sa_id" {
  value = yandex_iam_service_account.cicd_staging.id
}

output "cicd_viewer_sa_id" {
  value = yandex_iam_service_account.cicd_viewer.id
}

# Static access keys for CI/CD service accounts
output "cicd_production_access_key" {
  value     = yandex_iam_service_account_static_access_key.cicd_production_key.access_key
  sensitive = true
}

output "cicd_production_secret_key" {
  value     = yandex_iam_service_account_static_access_key.cicd_production_key.secret_key
  sensitive = true
}

output "cicd_staging_access_key" {
  value     = yandex_iam_service_account_static_access_key.cicd_staging_key.access_key
  sensitive = true
}

output "cicd_staging_secret_key" {
  value     = yandex_iam_service_account_static_access_key.cicd_staging_key.secret_key
  sensitive = true
}

output "container_id" {
  value = yandex_serverless_container.container.id
}

output "container_name" {
  value = yandex_serverless_container.container.name
}
