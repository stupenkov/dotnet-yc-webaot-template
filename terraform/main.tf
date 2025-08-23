# Service Account
resource "yandex_iam_service_account" "sa" {
  name = "serverless-sa"
}

# IAM binding: give Service Account full access to serverless
resource "yandex_resourcemanager_folder_iam_binding" "sa_binding" {
  folder_id = var.folder_id
  role      = "serverless.functions.invoker"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}"
  ]
}

# Serverless Container
resource "yandex_serverless_container" "container" {
  name              = var.container_name
  description       = "Example Serverless Container"
  folder_id         = var.folder_id
  memory            = 128 # Moved from resources block
  execution_timeout = "15s"
  cores             = 1 # Moved from resources block
  core_fraction     = 5 # Moved from resources block

  image {
    url = var.container_image # Changed from 'name' to 'url'
  }
}
