variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "asia-northeast1"
}

variable "domain_name" {
  type = string
  description = "ドメイン名 (例: www.example.com)"
}

variable "dns_zone_name" {
  type = string
  description = "Cloud DNSのゾーン名 (例: example-com)"
}
