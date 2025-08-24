output "cloud_id" {
  value = yandex_resourcemanager_cloud.app_cloud.id
}

output "environments_summary" {
  description = "Complete summary of all environments"
  value = {
    for env_name, env_module in module.app_environment : env_name => {
      folder_id   = env_module.folder_id
      folder_name = env_module.folder_name
      network_id  = env_module.network_id
      subnet_ids  = env_module.subnet_ids
    }
  }
}
