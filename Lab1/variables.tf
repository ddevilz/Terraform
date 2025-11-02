variable "application_name" {
  type = string

  validation {
    condition     = length(var.application_name) >= 3 && length(var.application_name) <= 16
    error_message = "application_name must be at least 3 characters long and at most 16 characters long"
  }
}

variable "environment" {
  type = string
}

variable "api_key" {
  type      = string
  sensitive = true
}

variable "instance_count" {
  type = number

  validation {
    condition     = var.instance_count >= local.min_instance_count && var.instance_count <= local.max_instance_count
    error_message = "instance_count must be at least ${local.min_instance_count} and at most ${local.max_instance_count}"
  }
}

variable "enable_logging" {
  type = bool
}

variable "regions" {
  type = list(string)
}

variable "regions_instance_count" {
  type = map(string)

  # validation {
  #   condition     = var.regions_instance_count % 2 == 0
  #   error_message = "regions_instance_count must be a map with even number of elements"
  # }
}

variable "regions_set" {
  type = set(string)
}

variable "sku_settings" {
  type = object({
    kind = string
    tier = string
  })
}
