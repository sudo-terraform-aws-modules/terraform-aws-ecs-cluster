output "id" {
  value       = aws_ecs_cluster.cluster.id
  description = "ECS Cluster ID"
}

output "name" {
  value       = aws_ecs_cluster.cluster.name
  description = "ECS Cluster name"
}

output "arn" {
  value       = aws_ecs_cluster.cluster.arn
  description = "ECS Cluster ARN"
}

output "kms_key_arn" {
  value       = try(aws_kms_key.cluster[0].arn, null)
  description = "KMS Key ARN used for ECS Exec encryption, or null if create_kms_key is false"
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.cluster.name
  description = "CloudWatch Log Group name for ECS Exec logs"
}
