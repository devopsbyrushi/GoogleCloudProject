#################################################
# Google Cloud Configuration
#################################################

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud Region"
  type        = string
}

variable "zone" {
  description = "Google Cloud Zone"
  type        = string
}

#################################################
# Banking Project
#################################################

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "bankingproject2026"
}

#################################################
# Network
#################################################

variable "network_name" {
  description = "VPC Network Name"
  type        = string
  default     = "bankingproject2026-vpc"
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "bankingproject2026-subnet"
}

variable "subnet_cidr" {
  description = "Subnet CIDR Range"
  type        = string
  default     = "10.10.0.0/24"
}

#################################################
# Common Compute Engine Configuration
#################################################

variable "machine_type" {
  description = "Default machine type for lab servers"
  type        = string
  default     = "e2-medium"
}

variable "disk_size" {
  description = "Default boot disk size in GB"
  type        = number
  default     = 20
}

variable "image" {
  description = "Ubuntu 24.04 LTS image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
}

#################################################
# Jenkins Server
#################################################

variable "jenkins_machine_type" {
  description = "Machine type for Jenkins server"
  type        = string
  default     = "e2-medium"
}

variable "jenkins_disk_size" {
  description = "Boot disk size for Jenkins server in GB"
  type        = number
  default     = 20
}

#################################################
# Ansible Server
#################################################

variable "ansible_machine_type" {
  description = "Machine type for Ansible server"
  type        = string
  default     = "e2-medium"
}

variable "ansible_disk_size" {
  description = "Boot disk size for Ansible server in GB"
  type        = number
  default     = 20
}

#################################################
# SonarQube Server
#################################################

variable "sonarqube_machine_type" {
  description = "Machine type for SonarQube server"
  type        = string
  default     = "e2-medium"
}

variable "sonarqube_disk_size" {
  description = "Boot disk size for SonarQube server in GB"
  type        = number
  default     = 20
}

#################################################
# Monitoring Server
#################################################

variable "monitoring_machine_type" {
  description = "Machine type for Monitoring server"
  type        = string
  default     = "e2-medium"
}

variable "monitoring_disk_size" {
  description = "Boot disk size for Monitoring server in GB"
  type        = number
  default     = 20
}
