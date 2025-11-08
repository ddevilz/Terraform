resource "random_string" "name" {
  length  = 6
  upper   = false
  special = false
}

locals {
  environment_prefix = "${var.application_name}_${var.environment}_${random_string.name.result}"
  min_instance_count = 1
  max_instance_count = 10

  regional_stamps = [
    {
      region         = var.regions[0]
      name           = "Alpha"
      min_node_count = 5
      max_node_count = 6
    },
    {
      region         = var.regions[1]
      name           = "Bravo"
      min_node_count = 3
      max_node_count = 4
    }
  ]

  regional_stamps_map = {
    "foo" = {
      region         = var.regions[0]
      name           = "Alpha"
      min_node_count = 5
      max_node_count = 6
    },
    "bar" = {
      region         = var.regions[1]
      name           = "Bravo"
      min_node_count = 3
      max_node_count = 4
    }
  }
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

module "regional_stamp" {

  source = "./modules/regional-stamp"

  count = length(local.regional_stamps)

  region         = local.regional_stamps[count.index].region
  name           = local.regional_stamps[count.index].name
  min_node_count = local.regional_stamps[count.index].min_node_count
  max_node_count = local.regional_stamps[count.index].max_node_count
}

module "regional_stamp_map" {

  source = "./modules/regional-stamp"

  for_each = local.regional_stamps_map

  region         = each.value.region
  name           = each.value.name
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count
}

# module "regionA" {
#   source         = "./modules/regional-stamp"
#   region         = var.regions[0]
#   name           = "Alpha"
#   min_node_count = 5
#   max_node_count = 6
# }

# module "regionB" {
#   source         = "./modules/regional-stamp"
#   region         = var.regions[1]
#   name           = "Bravo"
#   min_node_count = 3
#   max_node_count = 4
# }

