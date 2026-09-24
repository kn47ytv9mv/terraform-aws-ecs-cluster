variable "name" {
  default     = null
  description = "The name of the ECS cluster. If null, a unique name is generated."
}

variable "container_insights" {
  default     = null
  description = "Whether to enable CloudWatch Container Insights for the cluster. If null, AWS's default (disabled) applies."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the cluster."
}
