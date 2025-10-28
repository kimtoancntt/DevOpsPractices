resource "random_string" "acr_suffix" {
  length  = 6
  upper   = false
  special = false
}

# ----------------------------------------------------------
# Install Resource Groups, ACR, VNet, AKS
# ----------------------------------------------------------
module "resource_group" {
  source = "./modules/resource_groups"
  name = var.resource_group_name
  location = var.location
  tags = var.tags
}

module "container_registry" {
  source = "./modules/container_registry"
  name = "${var.container_registry_name}"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  sku = var.container_registry_sku
  tags = var.tags

  depends_on = [ module.resource_group ]
}


module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix

  depends_on = [ module.resource_group ]
}

module "kubernetes_service" {
  source              = "./modules/kubernetes_service"
  resource_group_name = "${module.resource_group.name}"
  location            = var.location
  cluster_name        = "${var.cluster_name}"
  dns_prefix          = var.dns_prefix
  node_pool_name      = var.node_pool_name
  node_count          = var.node_count
  vm_size             = var.vm_size
  subnet_id           = module.network.subnet_id
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  depends_on = [ module.network, module.resource_group ]
}

module "attaching_acr_aks" {
  source = "./Modules/Attaching_ACR_AKS"
  aks_identity_id = module.kubernetes_service.identity_id
  acr_scope = module.container_registry.id

  depends_on = [ module.container_registry, module.kubernetes_service ]
}

# ----------------------------------------------------------
# Wait AKS ready
# ----------------------------------------------------------
resource "null_resource" "wait_for_aks" {
  depends_on = [module.kubernetes_service]

  provisioner "local-exec" {
    command = "powershell -Command \"Start-Sleep -Seconds 360\""
  }
}

# ----------------------------------------------------------
# Install Prometheus + Grafana
# ----------------------------------------------------------
module "monitoring" {
  source     = "./Modules/Prometheus_Grafana"
  depends_on = [null_resource.wait_for_aks]

  providers = {
    kubernetes = kubernetes.aks
    helm       = helm.aks
  }
}