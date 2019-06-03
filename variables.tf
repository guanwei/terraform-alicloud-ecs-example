variable "region" {
  default = "cn-shanghai"
}

variable "access_key" {
}

variable "secret_key" {
}

variable "vpc_name" {
  default = "hsc-dev"
}

variable "count" {
  default = "1"
}

variable "count_format" {
  default = "%02d"
}

variable "app_name" {
  default = "example"
}

variable "env_name" {
  default = "dev"
}

variable "image_id" {
  default = "centos_7_06_64_20G_alibase_20190218.vhd"
}

variable "internet_charge_type" {
  default = "PayByTraffic"
}

variable "internet_max_bandwidth_out" {
  default = 5
}

variable "password" {
}

variable "instance_charge_type" {
  default = "PostPaid"
}

variable "system_disk_category" {
  default = "cloud_efficiency"
}
