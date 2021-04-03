output "cluster_cert" {
  value = aws_eks_cluster.cluster.certificate_authority.*.data
}

output "cluster_oidc_issuer" {
  value = aws_eks_cluster.cluster.identity[*].oidc[*].issuer
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}


output "cluster_version" {
  value = var.cluster_version
}

output "cluster_log_types" {
  value = var.cluster_log_types
}

output "cluster_platform_version" {
  value = aws_eks_cluster.cluster.platform_version
}

output "cluster_status" {
  value = aws_eks_cluster.cluster.status
}

output "environment" {
  value = var.environment
}

output "name" {
  value = var.name
}

output "private_zone_id" {
  value = var.private_zone_id
}

output "public_zone_id" {
  value = var.public_zone_id
}

output "region" {
  value = var.region
}

output "stateful_worker_subnet_ids" {
  value = var.stateful_worker_subnet_ids
}

output "stateful_worker_disk_size" {
  value = var.stateful_worker_disk_size
}

output "stateful_worker_instance_type" {
  value = var.stateful_worker_instance_type
}

output "stateful_worker_min_size" {
  value = var.stateful_worker_min_size
}

output "stateful_worker_max_size" {
  value = var.stateful_worker_max_size
}

output "stateful_worker_desired_size" {
  value = var.stateful_worker_desired_size
}
