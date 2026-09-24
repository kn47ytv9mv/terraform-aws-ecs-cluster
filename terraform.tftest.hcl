mock_provider "aws" {}

run "default_creates_cluster_with_generated_name" {
  command = apply

  assert {
    condition     = aws_ecs_cluster.resource.name == random_uuid.resource.id
    error_message = "With no name given, the cluster should use the generated random_uuid."
  }

  assert {
    condition     = length(aws_ecs_cluster.resource.setting) == 0
    error_message = "container_insights left unset should omit the setting block entirely."
  }
}

run "explicit_name_overrides_generated_uuid" {
  command = plan

  variables {
    name = "example"
  }

  assert {
    condition     = aws_ecs_cluster.resource.name == "example"
    error_message = "An explicit name should be used instead of the generated UUID."
  }
}

run "container_insights_enabled" {
  command = plan

  variables {
    container_insights = true
  }

  assert {
    condition     = one(aws_ecs_cluster.resource.setting).name == "containerInsights"
    error_message = "container_insights = true should add a containerInsights setting block."
  }

  assert {
    condition     = one(aws_ecs_cluster.resource.setting).value == "enabled"
    error_message = "container_insights = true should map to the literal string 'enabled'."
  }
}

run "container_insights_disabled_explicitly" {
  command = plan

  variables {
    container_insights = false
  }

  assert {
    condition     = one(aws_ecs_cluster.resource.setting).value == "disabled"
    error_message = "container_insights = false should map to the literal string 'disabled', not omit the block."
  }
}

run "readme_registry_source" {
  command = plan

  variables {
    name = "example"
  }
}
