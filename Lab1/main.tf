resource "random_string" "name" {
  length  = 6
  upper   = false
  special = false
}

locals {
  environment_prefix = "${var.application_name}_${var.environment}_${random_string.name.result}"
  min_instance_count = 1
  max_instance_count = 10
}

