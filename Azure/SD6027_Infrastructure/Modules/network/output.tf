
output "subnet_id" {
  description = "The ID of the subnet to be used by AKS"
  value       = azurerm_subnet.aks_subnet.id
}
