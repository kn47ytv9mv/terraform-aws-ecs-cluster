resource "random_uuid" "resource" {}

resource "aws_ecs_cluster" "resource" {
  name = coalesce(var.name, random_uuid.resource.id)

  dynamic "setting" {
    for_each = var.container_insights[*]

    content {
      name  = "containerInsights"
      value = setting.value ? "enabled" : "disabled"
    }
  }

  tags = var.tags
}

output "id" {
  description = "The ID of the cluster."
  value       = aws_ecs_cluster.resource.id
}

output "name" {
  description = "The name of the cluster. Feed this into terraform-aws-monitoring-baseline's ecs_services — CloudWatch dimensions the service metrics on the cluster name, not its ARN."
  value       = aws_ecs_cluster.resource.name
}

output "arn" {
  description = "The ARN of the cluster."
  value       = aws_ecs_cluster.resource.arn
}
