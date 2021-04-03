variable "cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "controllerManager", "scheduler"]
}

variable "cluster_version" {
  type    = string
  default = "1.17"

  validation {
    condition     = can(regex("^1.(14|15|16|17)$", var.cluster_version))
    error_message = "The cluster_version is not valid."
  }
}

variable "environment" {
  type = string

  validation {
    condition     = can(regex("^(test|dev|qa|stage)$", var.environment))
    error_message = "The environment can be either test/dev/qa/stage."
  }
}

variable "name" {}

variable "private_zone_id" {}

variable "private_zone_name" {}

variable "public_zone_id" {}

variable "public_zone_name" {}

variable "region" {
  type = string

  validation {
    condition     = can(regex("^(us|af|ap|ca|eu|me|sa)\\-(east|west|south|northeast|southeast|central|north)\\-(1|2|3)$", var.region))
    error_message = "The region must be a proper AWS region."
  }
}

variable "stateful_worker_subnet_ids" {
  type = list(string)
}

variable "stateful_worker_min_size" {
  type    = number
  default = 1
}

variable "stateful_worker_max_size" {
  type    = number
  default = 2
}

variable "stateful_worker_desired_size" {
  type    = number
  default = 1
}

variable "stateful_worker_disk_size" {
  type    = number
  default = 20
}

variable "stateful_worker_instance_type" {
  type    = string
  default = "t2.micro"

  validation {
    condition     = can(regex("^(t1|t2|t3|t3a|t4g|m1|m2|m3|m4|m5|cr1|r3|r4|r5|r5a|r5d|r5ad|r6g|r6gd|x1|x1e|i2|i3|i3en|hi1|c1|c3|c4|c5|c5a|c5ad|c5d|c5n|c6g|c6gd|cc1|g2|g3|g3s|g4dn|cg1|p2|p3|d2|f1)\\.(nano|micro|small|medium|large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge|24xlarge|metal)$", var.stateful_worker_instance_type))
    error_message = "Option instance_type must at be a supported instance_type (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html)."
  }
}
