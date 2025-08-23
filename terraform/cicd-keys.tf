resource "yandex_iam_service_account_static_access_key" "cicd_production_key" {
  service_account_id = yandex_iam_service_account.cicd_production.id
  description        = "Static access key for CI/CD production"
}

resource "yandex_iam_service_account_static_access_key" "cicd_staging_key" {
  service_account_id = yandex_iam_service_account.cicd_staging.id
  description        = "Static access key for CI/CD staging"
}

resource "yandex_iam_service_account_static_access_key" "cicd_viewer_key" {
  service_account_id = yandex_iam_service_account.cicd_viewer.id
  description        = "Static access key for CI/CD viewer"
}
