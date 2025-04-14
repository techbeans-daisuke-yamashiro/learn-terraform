variable "project_id" {
  type = string
}
variable "region" {
  type    = string
  default = "asia-northeast1"
}
variable "initial_node_count" {
  type    = number
  default = 0
}

variable "deployment_replicas" {}
variable "service_port" {}
variable "service_target_port" {}
variable "http_health_check_interval" {}
variable "http_health_check_timeout" {}
variable "http_health_check_healthy_threshold" {}
variable "http_health_check_unhealthy_threshold" {}
variable "backend_service_timeout" {}