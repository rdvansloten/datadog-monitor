terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.23.0"
    }
  }
}

provider "azurerm" {
  features {}
}