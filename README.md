# terraform-aws-ecs-cluster

Terraform module for an ECS cluster.

## Cost

An ECS cluster carries no charge of its own — cost comes from the
compute that runs within it (Fargate tasks or EC2 instances). Enabling
`container_insights` adds CloudWatch metrics and logs charges. See AWS's
[CloudWatch pricing](https://aws.amazon.com/cloudwatch/pricing/) page
for Container Insights rates.

## Usage

```hcl
module "cluster" {
  source = "kn47ytv9mv/ecs-cluster/aws"

  name = "example"
}
```

Or directly from this repository:

```hcl
module "cluster" {
  source = "github.com/kn47ytv9mv/terraform-aws-ecs-cluster"

  name = "example"
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| name | The name of the ECS cluster. If null, a unique name is generated. | `null` | no |
| container_insights | Whether to enable CloudWatch Container Insights for the cluster. If null, AWS's default (disabled) applies. | `null` | no |
| tags | A map of tags to assign to the cluster. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the cluster. |
| arn | The ARN of the cluster. |
| name | The name of the cluster. Feed this into `terraform-aws-monitoring-baseline`'s `ecs_services` — CloudWatch dimensions service metrics on the cluster name, not its ARN. |

## License

MIT — see [LICENSE.md](LICENSE.md).
