resource "yandex_resourcemanager_folder" "this" {
  cloud_id    = var.cloud_id
  name        = "env-${var.environment_name}"
  description = var.environment_description != "" ? var.environment_description : "Folder for ${var.environment_name} environment"
}

# Service accounts
resource "yandex_iam_service_account" "cicd" {
  folder_id   = yandex_resourcemanager_folder.this.id
  name        = "sa-cicd-${var.environment_name}"
  description = "Service account for CI/CD pipelines in production environment"
}

resource "yandex_resourcemanager_folder_iam_member" "cicd_editor" {
  folder_id = yandex_resourcemanager_folder.this.id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.cicd.id}"
}

# -----
resource "yandex_iam_service_account" "sa_app" {
  name      = "sa-app-${var.environment_name}"
  folder_id = yandex_resourcemanager_folder.this.id
}

resource "yandex_resourcemanager_folder_iam_binding" "sa_app_binding" {
  folder_id = yandex_resourcemanager_folder.this.id
  role      = "serverless-containers.containerInvoker"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_app.id}"
  ]
}

# Network
resource "yandex_vpc_network" "this" {
  folder_id   = yandex_resourcemanager_folder.this.id
  name        = "net-${var.environment_name}"
  description = "Network for ${var.environment_name} environment"
}

resource "yandex_vpc_subnet" "this" {
  for_each = toset(["a", "b", "d"])

  folder_id      = yandex_resourcemanager_folder.this.id
  name           = "subnet-${var.environment_name}-${each.key}"
  zone           = "ru-central1-${each.key}"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["10.${index(["a", "b", "d"], each.key)}.0.0/24"]
}

# Other resources
resource "yandex_container_registry" "this" {
  name      = "default"
  folder_id = yandex_resourcemanager_folder.this.id
}

# App
resource "yandex_serverless_container" "container" {
  name               = var.app_name
  description        = "Example Serverless Container"
  folder_id          = yandex_resourcemanager_folder.this.id
  service_account_id = yandex_iam_service_account.sa_app.id
  memory             = 128
  execution_timeout  = "15s"
  cores              = 1
  core_fraction      = 5

  image {
    url = "cr.yandex/${yandex_container_registry.this.id}/${var.app_name}:latest"
  }

  lifecycle {
    ignore_changes = [image]
  }
}
