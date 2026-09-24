resource "aws_kms_key" "cluster" {
  count = var.create_kms_key ? 1 : 0

  description             = "KMS Key for ${local.cluster_name}"
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "cluster" {
  count = var.create_kms_key ? 1 : 0

  name          = "alias/${local.cluster_name}"
  target_key_id = aws_kms_key.cluster[0].key_id
}

resource "aws_cloudwatch_log_group" "cluster" {
  name              = "/ecs/${local.cluster_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name

  dynamic "configuration" {
    for_each = var.create_kms_key ? [1] : []
    content {
      execute_command_configuration {
        kms_key_id = aws_kms_key.cluster[0].arn
        logging    = "OVERRIDE"

        log_configuration {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name     = aws_cloudwatch_log_group.cluster.name
        }
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = var.tags
}
