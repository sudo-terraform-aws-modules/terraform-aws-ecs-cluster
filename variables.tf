variable "name" {
  type        = string
  description = "(optional) Cluster name. Default: randomly generated"
  default     = null
}

variable "container_insights" {
  type        = bool
  description = "(optional) Enable Container Insights. Default: true"
  default     = true
}

variable "create_kms_key" {
  type        = bool
  description = "(optional) Create a KMS key for ECS Exec encryption. When false, ECS Exec logging runs without encryption. Default: true"
  default     = true
}

variable "kms_key_deletion_window" {
  type        = number
  description = "(optional) KMS key deletion window in days. Default: 7"
  default     = 7
  validation {
    condition     = var.kms_key_deletion_window >= 7 && var.kms_key_deletion_window <= 30
    error_message = "kms_key_deletion_window must be between 7 and 30 days."
  }
}

variable "log_retention_days" {
  type        = number
  description = "(optional) CloudWatch log retention in days. Default: 90"
  default     = 90
}

variable "tags" {
  type        = map(string)
  description = "(optional) Tags to apply to all resources."
  default     = {}
}
