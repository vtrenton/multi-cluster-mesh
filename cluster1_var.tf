variable "aws_region" {
    type        = string
    default     = "us-east-1"
    description = "Region used to create cluster"
}

variable "cluster_name" {
    type        = string
    default     = "Cluster1"
    description = "Name of the cluster"
}

variable "cluster_version" {
    type        = string
    default     = "1.29"
    description = "Kubernetes version"
}

variable "instance_size" {
    type        = string
    default     = "t3.medium"
    description = "Instance of EC2 workers"
}

variable "node_group_name" {
    type        = string
    default     = "cluster1-node-group"
    description = "Name of the EKS node group"
}

variable "priv_key_file" {
    type        = string
    default     = "cluster1_key.pem"
    description = "Private key output path for cluster ssh access"
}

variable "kubeconfig_file" {
    type        = string
    default     = "cluster1.yaml"
    description = "Private key output path for cluster ssh access"
}

variable "vpc_cidr" {
    type        = string
    default     = "10.0.0.0/16"
    description = "The network assigned to the VPC"
}

variable "az_a" {
    type        = string
    default     = "us-east-1a"
    description = "Availablity Zone for Subnet A"
}

variable "az_b" {
    type        = string
    default     = "us-east-1b"
    description = "Availablity Zone for Subnet B"
}

variable "az_subnet" {
    type        = number
    default     = 8
    description = "Number of additional bits needed to get from the VPC cidr to subnet"
}

variable "worker_iam_role_name" {
    type        = string
    default     = "cluster1_worker"
    description = "Name of worker node iam role"
}

variable "cluster_iam_role_name" {
    type        = string
    default     = "cluster1_cluster"
    description = "name of the cluster IAM role"
}

variable "cloudwatch_iam_role_name" {
  type        = string
  default     = "eksCloudwatch"
  description = "Name of the Worker Node iam role"
}

variable "elb_iam_role_name" {
  type        = string
  default     = "eksELBPolicy"
  description = "Name of the Worker Node iam role"
}
