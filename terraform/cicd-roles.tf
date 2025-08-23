resource "yandex_resourcemanager_folder_iam_member" "cicd_production_editor" {
  folder_id = yandex_resourcemanager_folder.production.id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.cicd_production.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "cicd_staging_editor" {
  folder_id = yandex_resourcemanager_folder.staging.id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.cicd_staging.id}"
}

# Optional: we give the service account viewer rights for reading configurations or secrets
resource "yandex_resourcemanager_folder_iam_member" "cicd_viewer_viewer" {
  folder_id = yandex_resourcemanager_folder.production.id
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.cicd_viewer.id}"
}

# Optional: we give the service account viewer rights for reading configurations or secrets
resource "yandex_resourcemanager_folder_iam_member" "cicd_staging_viewer_production" {
  folder_id = yandex_resourcemanager_folder.production.id
  role      = "viewer"
  member    = "serviceAccount:${yandex_iam_service_account.cicd_staging.id}"
}
