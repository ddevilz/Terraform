environment    = "prod"
instance_count = 2
enable_logging = true
regions        = ["eastus", "westus", "westus2"]
regions_instance_count = {
  eastus = 4
  westus = 8
}
regions_set = ["eastus", "westus"]
sku_settings = {
  kind = "StorageV2"
  tier = "Standard_LRS"
}
