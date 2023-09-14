variable "project" {
  type = string
  description = "GCP Project"
}

variable "region" {
  type = string
  description = "GCP Region"
}

variable "zone" {
  type = string
  description = "GCP Zone"
}

variable "network_name" {
  type = string
  default = null
  description = "GCP compute network name"
}

variable "redis_name" {
  type = string
  description = "Redis instance name"
}

