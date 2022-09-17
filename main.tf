resource "aws_kms_key" "cluster" {
  description             = "KMS Key for ${local.cluster_name}"
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "cluster" {
  name = local.cluster_name
}

resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cluster.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.cluster.name
      }
    }
  }
  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }
}
