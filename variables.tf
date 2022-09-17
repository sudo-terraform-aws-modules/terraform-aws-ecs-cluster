variable "name" {
  type        = string
  description = "(optional) Specify the cluster name. Default: random name prefix with sudo"
  default     = null
}

variable "container_insights" {
  type        = bool
  description = "(optional) Should the container insights be enabled. Default: true"
  default     = true
}
