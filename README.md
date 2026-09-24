# SUDO AWS Terraform Module for ECS Cluster

Creates an AWS ECS Cluster with optional KMS encryption for ECS Exec, CloudWatch logging, and Container Insights.

## Usage

### Basic Cluster

```hcl
module "ecs_cluster" {
  source  = "sudo-terraform-aws-modules/ecs-cluster/aws"
  version = "1.0.0"

  name               = "my-cluster"
  container_insights = true
}
```

### Cluster with KMS Encryption for ECS Exec

```hcl
module "ecs_cluster" {
  source  = "sudo-terraform-aws-modules/ecs-cluster/aws"
  version = "1.0.0"

  name                    = "my-cluster"
  container_insights      = true
  create_kms_key          = true
  kms_key_deletion_window = 14
  log_retention_days      = 30

  tags = { Environment = "prod" }
}
```

### Cluster without KMS (no ECS Exec encryption)

```hcl
module "ecs_cluster" {
  source  = "sudo-terraform-aws-modules/ecs-cluster/aws"
  version = "1.0.0"

  name           = "my-cluster"
  create_kms_key = false
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_kms_key.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_alias.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_cloudwatch_log_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Cluster name. Default: randomly generated | `string` | `null` | no |
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | Enable Container Insights | `bool` | `true` | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Create a KMS key for ECS Exec encryption. When false, ECS Exec logging runs without encryption | `bool` | `true` | no |
| <a name="input_kms_key_deletion_window"></a> [kms\_key\_deletion\_window](#input\_kms\_key\_deletion\_window) | KMS key deletion window in days (7–30) | `number` | `7` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch log retention in days | `number` | `90` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ECS Cluster ID |
| <a name="output_name"></a> [name](#output\_name) | ECS Cluster name |
| <a name="output_arn"></a> [arn](#output\_arn) | ECS Cluster ARN |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS Key ARN used for ECS Exec encryption, or null if create\_kms\_key is false |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | CloudWatch Log Group name for ECS Exec logs |
<!-- END_TF_DOCS -->
