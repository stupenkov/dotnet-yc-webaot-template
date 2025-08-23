resource "yandex_iam_service_account" "serverless-sa-staging" {
  name      = "serverless-sa"
  folder_id = yandex_resourcemanager_folder.staging.id
}

resource "yandex_resourcemanager_folder_iam_binding" "sa_binding_staging_serverless_invoker" {
  folder_id = yandex_resourcemanager_folder.staging.id
  role      = "serverless-containers.containerInvoker"
  members = [
    "serviceAccount:${yandex_iam_service_account.serverless-sa-staging.id}"
  ]
}

resource "yandex_container_registry" "default" {
  name      = "default"
  folder_id = yandex_resourcemanager_folder.staging.id
}

resource "yandex_serverless_container" "container" {
  name               = var.app_name
  description        = "Example Serverless Container"
  folder_id          = yandex_resourcemanager_folder.staging.id
  service_account_id = yandex_iam_service_account.serverless-sa-staging.id
  memory             = 128
  execution_timeout  = "15s"
  cores              = 1
  core_fraction      = 5

  image {
    url = "cr.yandex/${yandex_container_registry.default.id}/${var.app_name}:latest"
  }

  lifecycle {
    ignore_changes = [image]
  }
}
