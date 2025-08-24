
# Infrastructure
resource "yandex_resourcemanager_folder" "infra" {
  cloud_id    = yandex_resourcemanager_cloud.app_cloud.id
  name        = "infrastructure"
  description = "Folder for infrastructure components"
}

resource "yandex_storage_bucket" "infra" {
  bucket    = "terraform-${yandex_resourcemanager_folder.infra.id}"
  folder_id = yandex_resourcemanager_folder.infra.id
}

output "s3_bucket_name" {
  value = yandex_storage_bucket.infra.bucket
}

