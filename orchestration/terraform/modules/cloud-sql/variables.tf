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
  description = "Network name"
}

variable "database_user_name" {
  type = string
  description = "Database user name"
}

variable "database_name" {
  type = string
  description = "Database name"
}

variable "sql_dependency" {
  type = any
  default = null
  description = "SQL dependency on compute network"
}
