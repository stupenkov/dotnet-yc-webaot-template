output "folder_id" {
  description = "ID of the created folder"
  value       = yandex_resourcemanager_folder.this.id
}

output "folder_name" {
  description = "Name of the created folder"
  value       = yandex_resourcemanager_folder.this.name
}

output "network_id" {
  description = "ID of the created network"
  value       = yandex_vpc_network.this.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = { for k, v in yandex_vpc_subnet.this : k => v.id }
}
