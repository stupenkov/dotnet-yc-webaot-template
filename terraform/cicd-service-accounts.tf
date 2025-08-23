resource "yandex_iam_service_account" "cicd_production" {
  folder_id   = yandex_resourcemanager_folder.production.id
  name        = "cicd-production"
  description = "Service account for CI/CD pipelines in production environment"
}

resource "yandex_iam_service_account" "cicd_viewer" {
  folder_id   = yandex_resourcemanager_folder.production.id
  name        = "cicd-viewer"
  description = "Service account for read-only operations in CI/CD"
}

resource "yandex_iam_service_account" "cicd_staging" {
  folder_id   = yandex_resourcemanager_folder.staging.id
  name        = "cicd-staging"
  description = "Service account for CI/CD pipelines in staging environment"
}
