# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "state-sta" {
    name = "${lower(var.company)}tf${random_string.tf-name.result}"
  resource_group_name = var.resource_group_name
  location = var.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  access_tier = "Hot"
  account_replication_type = "ZRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = true
  }
  tags = {
    environment = var.environment
  }
}
# Create a Storage Container for the Core State File
resource "azurerm_storage_container" "core-container" {
  depends_on = [azurerm_storage_account.state-sta]
  name = "core-tfstate"
  storage_account_name = azurerm_storage_account.state-sta.name
}