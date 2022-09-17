output "name" {
  value       = aws_ecs_cluster.cluster.name
  description = "ECS Cluster name"
}

output "arn" {
  value       = aws_ecs_cluster.cluster.arn
  description = "ECS Cluster ARN"
}
