variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "zone" {
  description = "Google Cloud zone"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "node_pool_name" {
  description = "GKE node pool name"
  type        = string
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
}

variable "machine_type" {
  description = "GKE worker node machine type"
  type        = string
}

variable "pods_secondary_range_name" {
  description = "Existing secondary range name for Kubernetes Pods"
  type        = string
}

variable "services_secondary_range_name" {
  description = "Existing secondary range name for Kubernetes Services"
  type        = string
}
