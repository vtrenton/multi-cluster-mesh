# Create EKS Cluster
provider "aws" {
    region = var.aws_region
}

# Key for secrets encryption
resource "aws_kms_key" "secret_key" {
    description = "KMS key for Rancher Secret Encryption"
}

# Create EKS Cluster for Rancher to live on
resource "aws_eks_cluster" "cluster1" {
    name     = var.cluster_name
    version  = var.cluster_version
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
        subnet_ids = [
            aws_subnet.sub_a.id,
            aws_subnet.sub_b.id
        ]

        endpoint_private_access = true
        endpoint_public_access  = true
    }

    encryption_config {
        provider {
            key_arn = aws_kms_key.secret_key.arn
        }
        resources = ["secrets"]
    }
    
    depends_on = [
        aws_vpc.cluster_lan,
        aws_internet_gateway.cluster_gw,
        aws_subnet.sub_a,
        aws_subnet.sub_b
    ]
}

# launch config for workers
resource "aws_launch_template" "cluster1_workers" {
    name_prefix   = "worker-"
    instance_type = var.instance_size
    
    # ssh key name
    key_name      = aws_key_pair.generated_key.key_name    

    vpc_security_group_ids = [aws_security_group.eks_worker_sg.id]
    
    lifecycle {
        create_before_destroy = true
    }
}

# Create a node group for the workers
resource "aws_eks_node_group" "cluster1_node_group" {
  cluster_name    = aws_eks_cluster.cluster1.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = [
    aws_subnet.sub_a.id,
    aws_subnet.sub_b.id
  ]

  # Rancher scaling recommendations
  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 1
  }

  # Specify the launch template and version
  launch_template {
    id      = aws_launch_template.cluster1_workers.id
    version = "$Latest"
  }

  depends_on = [
    aws_eks_cluster.cluster1
  ]
}
