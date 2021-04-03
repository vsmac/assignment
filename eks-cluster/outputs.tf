output "cluster_cert" {
  value = module.eks.cluster_cert
}

output "cluster_oidc_issuer" {
  value = module.eks.cluster_oidc_issuer
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_version" {
  value = module.eks.cluster_version
}

output "cluster_log_types" {
  value = module.eks.cluster_log_types
}

output "cluster_platform_version" {
  value = module.eks.cluster_platform_version
}

output "cluster_status" {
  value = module.eks.cluster_status
}

output "environment" {
  value = var.environment
}

output "name" {
  value = var.name
}

output "region" {
  value = var.region
}

output "vpc" {
  value = data.aws_vpc.vpc.id
}

output "stateful_worker_subnet_ids" {
  value = data.aws_subnet_ids.stateful_worker_subnet_ids.ids
}

output "stateful_worker_disk_size" {
  value = module.eks.stateful_worker_disk_size
}

output "stateful_worker_instance_type" {
  value = module.eks.stateful_worker_instance_type
}

output "stateful_worker_min_size" {
  value = module.eks.stateful_worker_min_size
}

output "stateful_worker_max_size" {
  value = module.eks.stateful_worker_max_size
}

output "stateful_worker_desired_size" {
  value = module.eks.stateful_worker_desired_size
}
