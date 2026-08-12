
# GKE Cluster Provisioning Using Terraform

## Introduction to GKE

Google Kubernetes Engine (GKE) is a managed Kubernetes service provided by Google Cloud. It allows us to create and manage Kubernetes clusters without manually managing the Kubernetes control plane.

In this phase, we will use **Terraform** to provision a basic GKE cluster for our banking project.

The cluster will be created with a minimum of **2 nodes** for testing and training purposes.

The existing VPC and subnet created during the Terraform infrastructure phase will be reused. We will not create a new VPC or modify the existing network.

---

# Phase 4 Objective

In this phase, we will:

* Provision a GKE cluster using Terraform
* Use the existing VPC
* Use the existing GKE subnet
* Create a basic GKE node pool
* Create 2 worker nodes
* Use `e2-medium` machine type
* Configure Terraform outputs
* Verify the GKE cluster
* Connect to the cluster using `kubectl`

---

# Lab Architecture

```text
Google Cloud Project
        │
        ▼
Existing VPC
bankingproject2026-vpc
        │
        ▼
Existing GKE Subnet
bankingproject2026-gke-subnet
        │
        ▼
      GKE Cluster
bankingproject2026-gke
        │
        ▼
    Node Pool
bankingproject2026-node-pool
        │
       ┌┴┐
       │ │
      Node 1
      Node 2
```

---

# Existing Infrastructure

The VPC and subnet were already created in the previous Terraform phase.

We will reuse:

```text
VPC:
bankingproject2026-vpc

GKE Subnet:
bankingproject2026-gke-subnet
```

> We are **not creating another VPC or subnet** in this phase.

---

# GKE Cluster Configuration

For this training project, we will use a basic configuration.

```text
Project        : bankingproject2026
Region         : us-central1
Zone           : us-central1-a

Cluster Name   : bankingproject2026-gke

Node Pool      : bankingproject2026-node-pool

Node Count     : 2

Machine Type   : e2-medium
```

This configuration is sufficient for our initial Kubernetes testing.

---

# Terraform File Structure

The Phase 4 Terraform configuration contains the following files:

```text
GKE2/
│
├── 01-provider.tf
├── 02-apis.tf
├── 03-variables.tf
├── 04-network.tf
├── 05-cluster.tf
├── 06-node-pool.tf
├── 07-outputs.tf
│
└── terraform.tfvars
```

Each file has a specific responsibility.

---

# 01-provider.tf

This file configures the Google Cloud Terraform provider.

The provider connects Terraform with our Google Cloud project.

The important configuration is:

```text
Project
Region
Zone
```

---

# 02-apis.tf

This file enables the Google Cloud APIs required for GKE.

The main APIs required include:

```text
Compute Engine API
Kubernetes Engine API
```

Terraform can enable these APIs before creating the GKE resources.

---

# 03-variables.tf

This file contains the input variables used by the GKE configuration.

Examples include:

```text
project_id
region
zone
cluster_name
node_pool_name
node_count
machine_type
vpc_name
subnet_name
```

Using variables makes the Terraform configuration easier to reuse.

---

# 04-network.tf

This file does **not create a new VPC**.

Instead, Terraform reads the existing network and subnet.

```text
Existing VPC
     │
     ▼
Existing GKE Subnet
     │
     ▼
GKE Cluster
```

This allows us to keep the infrastructure created in the previous phase.

---

# 05-cluster.tf

This file creates the GKE cluster.

The cluster configuration includes:

```text
Cluster Name
Location
Network
Subnet
IP configuration
```

The cluster will use the existing network infrastructure.

---

# 06-node-pool.tf

This file creates the worker node pool.

For this training project:

```text
Node Pool:
bankingproject2026-node-pool

Node Count:
2

Machine Type:
e2-medium
```

Therefore, the initial cluster will contain:

```text
GKE Cluster
     │
     ▼
Node Pool
 ┌───────┐
 │       │
 ▼       ▼
Node 1  Node 2
```

---

# 07-outputs.tf

This file displays important information after Terraform creates the infrastructure.

For example:

```text
GKE Cluster Name
GKE Cluster Location
GKE Cluster Endpoint
VPC Name
Subnet Name
Node Pool Name
Node Count
Machine Type
```

These outputs make it easier to verify the infrastructure.

---

# terraform.tfvars

This file contains the actual values used by Terraform.

Example:

```text
project_id    = "bankingproject2026"

region        = "us-central1"

zone          = "us-central1-a"

cluster_name  = "bankingproject2026-gke"

node_pool_name = "bankingproject2026-node-pool"

node_count    = 2

machine_type  = "e2-medium"

vpc_name      = "bankingproject2026-vpc"

subnet_name   = "bankingproject2026-gke-subnet"
```

---

# Initializing Terraform

Open the Phase 4 Terraform directory.

```bash
cd GKE2
```

Initialize Terraform:

```bash
terraform init
```

This downloads the required Terraform providers and initializes the working directory.

---

# Formatting Terraform Files

Run:

```bash
terraform fmt
```

This automatically formats the Terraform configuration files.

---

# Validating the Configuration

Run:

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

# Reviewing the Terraform Plan

Before creating the GKE cluster, always review the Terraform plan.

```bash
terraform plan
```

The plan should show the resources that Terraform is going to create.

For our basic setup, we expect:

```text
GKE Cluster
Node Pool
```

The existing VPC and subnet should be read as existing resources and should **not be recreated**.

---

# Creating the GKE Cluster

After verifying the plan, run:

```bash
terraform apply
```

Terraform will ask for confirmation:

```text
Do you want to perform these actions?
```

Enter:

```text
yes
```

Terraform will then provision the GKE infrastructure.

---

# Verifying Terraform Output

After successful deployment, run:

```bash
terraform output
```

This displays the outputs configured in:

```text
07-outputs.tf
```

---

# Verifying the GKE Cluster

Use Google Cloud CLI to check the cluster.

```bash
gcloud container clusters list
```

Expected output will contain:

```text
bankingproject2026-gke
```

---

# Connecting kubectl to GKE

Configure `kubectl` credentials:

```bash
gcloud container clusters get-credentials bankingproject2026-gke \
  --zone us-central1-a \
  --project bankingproject2026
```

---

# Verify Kubernetes Nodes

Run:

```bash
kubectl get nodes
```

We should see approximately:

```text
NAME        STATUS   ROLES    AGE
gke-node1   Ready    <none>   ...
gke-node2   Ready    <none>   ...
```

The important point is that both nodes should show:

```text
Ready
```

---

# Verify Kubernetes Cluster

Run:

```bash
kubectl cluster-info
```

This confirms that `kubectl` can communicate with the GKE cluster.

---

# Verify All Nodes and Pods

Run:

```bash
kubectl get nodes -o wide
```

and:

```bash
kubectl get pods -A
```

This helps us understand the nodes and system pods running inside the cluster.

---

# Phase 4 Deployment Flow

The complete Terraform workflow is:

```text
Existing Google Cloud Infrastructure
              │
              ▼
       Existing VPC
              │
              ▼
       Existing GKE Subnet
              │
              ▼
        Terraform Init
              │
              ▼
       Terraform Validate
              │
              ▼
         Terraform Plan
              │
              ▼
         Terraform Apply
              │
              ▼
        GKE Cluster
              │
              ▼
          Node Pool
              │
        ┌─────┴─────┐
        ▼           ▼
      Node 1       Node 2
        │           │
        └─────┬─────┘
              ▼
        kubectl access
```

---

# Important Training Point

In this phase, Terraform is responsible for **provisioning the GKE infrastructure**.

```text
Terraform
   │
   ├── GKE Cluster
   │
   └── Node Pool
           │
           ├── Node 1
           └── Node 2
```

Kubernetes will be used in the next stages for:

```text
Deployments
Services
Pods
ConfigMaps
Secrets
Ingress
Autoscaling
Monitoring
```

---

# Common Terraform Commands

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
```

---

# Common GKE Commands

```bash
gcloud container clusters list

gcloud container clusters get-credentials bankingproject2026-gke \
  --zone us-central1-a \
  --project bankingproject2026

kubectl get nodes

kubectl get pods -A

kubectl cluster-info
```

---

# Cleanup

If the GKE cluster is no longer required for the lab, Terraform can remove the resources managed by this Phase 4 configuration.

```bash
terraform destroy
```

> **Important:** Before running `terraform destroy`, verify that the Terraform state contains only the Phase 4 resources. Do not destroy shared or existing infrastructure accidentally.

---

# Conclusion

In Phase 4, we provisioned a basic **Google Kubernetes Engine (GKE) cluster using Terraform**.

The cluster uses the existing networking infrastructure from the previous phase and contains a basic two-node worker pool.

The main flow is:

```text
Existing VPC
     ↓
Existing GKE Subnet
     ↓
Terraform
     ↓
GKE Cluster
     ↓
Node Pool
     ↓
2 Worker Nodes
     ↓
kubectl
```

This GKE cluster will be used as the foundation for the upcoming Kubernetes deployment and application deployment phases.
