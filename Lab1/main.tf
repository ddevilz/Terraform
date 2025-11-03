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

resource "random_string" "list" {

  count = length(var.regions)

  length  = 6
  upper   = false
  special = false
}

resource "random_string" "map" {

  for_each = var.regions_instance_count

  length  = 6
  upper   = false
  special = false
}

resource "random_string" "if" {

  count = var.enable_logging ? 1 : 0

  length  = 6
  upper   = false
  special = false
}

module "alpha" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "bravo" {
  source = "./modules/bravo"
  name   = "Bravo"
}
