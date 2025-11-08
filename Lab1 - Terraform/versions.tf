terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1" // = exact version  ~> patch releases >= any greater than qual version 
    }
  }
}
