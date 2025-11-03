output "application_name" {
  value = var.application_name
}

output "environment" {
  value = local.environment_prefix
}

output "name" {
  value = random_string.name.result
}

output "api_key" {
  value     = var.api_key
  sensitive = true
}

output "instance_count" {
  value = var.instance_count
}

output "enable_logging" {
  value = var.enable_logging
}

output "primary_region" {
  value = var.regions[0]
}

output "primary_region_instance_count" {
  value = var.regions_instance_count[var.regions[0]]
}

output "sku_settings_kind" {
  value = var.sku_settings.kind
}

output "alpha_random_string" {
  value = module.alpha.random_string
}

output "bravo_name" {
  value = module.bravo.name
}
