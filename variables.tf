variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}


variable "enabled_cluster_log_types" {
  description = "List of enabled cluster log types"
  type        = list(string)
  default     = []
}

variable "cluster_tags" {
  description = "Tags to apply to the EKS cluster"
  type        = map(string)
  default     = {
    Name = "Premium EKS Cluster"
    Env  = "development"
  }
}

variable "application_instance_types" {
    description = "Instance types for the EKS node group"
    type        = list(string)
    default     = ["t3.small"]
}

variable "gpu_instance_types" {
    description = "Instance types for the EKS node group"
    type        = list(string)
    default     = ["t3.small"]
} 

variable "node_group_desired_size" {
  description = "Desired size of the node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum size of the node group"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum size of the node group"
  type        = number
  default     = 1
}

variable "node_group_max_unavailable" {
  description = "Maximum unavailable nodes during update"
  type        = number
  default     = 1
}

variable "node_group_tags" {
  description = "Tags to apply to the node group"
  type        = map(string)
  default     = {
    Name = "Premium EKS NodeG-1"
    Env  = "development"
  }
}
