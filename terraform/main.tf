resource "yandex_resourcemanager_cloud" "app_cloud" {
  name            = var.cloud_name
  description     = "Cloud for ${var.cloud_name} application"
  organization_id = var.organization_id
}

resource "yandex_billing_cloud_binding" "binding" {
  billing_account_id = var.billing_account_id
  cloud_id           = yandex_resourcemanager_cloud.app_cloud.id
}

# Fix long-term billing binding
resource "time_sleep" "wait_for_cloud_activation" {
  depends_on      = [yandex_billing_cloud_binding.binding]
  create_duration = "60s"
}

module "app_environment" {
  for_each = var.environments

  source = "./modules/app_environment"

  cloud_id                = yandex_resourcemanager_cloud.app_cloud.id
  environment_name        = each.key
  environment_description = each.value.description
  app_name                = var.app_name
  depends_on              = [time_sleep.wait_for_cloud_activation]
  # You can pass additional variables for specific environments.
}
