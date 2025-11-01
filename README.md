# Project Overview

This project demonstrates a **DevOps end-to-end workflow** for deploying a containerized application to **Azure Kubernetes Service (AKS)** using:

- **Terraform** to provision cloud infrastructure
- **Docker** to build application images
- **Azure Container Registry (ACR)** to store images
- **AKS** to run the workloads
- **Prometheus + Grafana** for monitoring and observability
- **CI/CD pipeline** to automate build & deploy

The project simulates a real-world DevOps delivery pipeline with infrastructure automation and continuous deployment.

## Architecture

High-level architecture:

- Terraform provisions all cloud resources:
  - Azure Resource Group
  - Virtual Network & Subnet
  - Azure Kubernetes Service (AKS)
  - Azure Container Registry (ACR)
  - Monitoring namespace + Helm installation for Prometheus & Grafana

- CI/CD builds & pushes Docker image to ACR
- AKS pulls image from ACR and deploys the application
- Prometheus scrapes metrics from AKS
- Grafana visualizes system & application metrics

Flow:

```
Developer → Git Repo → CI Build (Docker) → ACR → CD Deploy to AKS
AKS APP → Prometheus → Grafana Dashboards
```

## Tech Stack

| Component | Technology |
|----------|-----------|
Infrastructure as Code | Terraform
Container | Docker
Container Registry | Azure Container Registry (ACR)
Compute | Azure Kubernetes Service (AKS)
Monitoring | Prometheus + Grafana (via Helm)
CI/CD | Azure Pipeline / GitHub Actions (configurable)
Language | YAML / Shell / Terraform HCL

## Folder Structure

### Application Repository (`SampleWeb`)
```
SampleWeb/
├── Dockerfile                 # Build container image
├── index.html                 # Simple web content
├── cicd-web-pipelines.yml     # CI/CD pipeline (build & deploy)
└── k8s/                       # Kubernetes deployment manifests
    ├── deployment.yaml        # Defines Deployment & image pull from ACR
    └── service.yaml           # Exposes app via LoadBalancer/ClusterIP
```

**Purpose**
| File | Description |
|------|-------------|
Dockerfile | Builds the web app container image
index.html | Static page used in Nginx image
cicd-web-pipelines.yml | Pipeline to build image, push to ACR, deploy to AKS
deployment.yaml | AKS Deployment referencing ACR container
device.yaml | Exposes the app service endpoint

---

### Infrastructure Repository (`DevOpsPractices/Azure/SD6027_Infrastructure`)
```
SD6027_Infrastructure/
├── main.tf                  # Root Terraform configuration
├── providers.tf             # Azure providers
├── variables.tf             # Global variables
├── Modules/
│   ├── resource_groups/     # Create Resource Group
│   ├── network/             # VNet + Subnet
│   ├── container_registry/  # Azure Container Registry (ACR)
│   ├── kubernetes_service/  # Azure Kubernetes Service (AKS)
│   ├── Attaching_ACR_AKS/   # Attach ACR permissions to AKS
│   └── Prometheus_Grafana/  # Monitoring setup via Helm
└── README.md
```

**Terraform Modules Explanation**
| Module | Function |
|--------|---------|
resource_groups | Creates Azure Resource Group
network | Creates VNet & Subnet for AKS
container_registry | Deploys ACR to store Docker images
kubernetes_service | Provisions AKS cluster
Attaching_ACR_AKS | Grants AKS pull permissions to ACR
Prometheus_Grafana | Installs monitoring stack with Helm

---

## How It Works

1. **Terraform** provisions cloud resources (RG, VNet, ACR, AKS, monitoring)
2. **Docker** builds the app image
3. **Pipeline** pushes image → ACR
4. **Kubernetes manifests** deploy app → AKS
5. **Prometheus + Grafana** visualize metrics

---

## Demo scenarios
https://wearenashtech.sharepoint.com/sites/Dept-HR/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FDept%2DHR%2FShared%20Documents%2FHR%5FTraining%2F01%2E%20Training%20Record%2F02%20%2D%20Technical%2FPractical%20DevOps%20for%20Devs%202025%2FAssignment%202025%2FSubmit%20Assignment%2FSD6027%5FBe%5FKim%5FToan%2FDemo%5FVideo&viewid=346917b7%2D71d5%2D4868%2D9879%2D89fef4a90701&ct=1761987257632&or=OWA%2DNT%2DMail&ga=1&LOF=1
