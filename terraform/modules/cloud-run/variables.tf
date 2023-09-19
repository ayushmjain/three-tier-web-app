variable "project" {
  type = string
  description = "GCP Project"
}

variable "region" {
  type = string
  description = "GCP Region"
}

variable "cloud_run_sa_id" {
  type = string
  description = "Cloud Run service account ID"
}

variable "cloud_run_service_name" {
  type = string
  description = "Cloud Run service name"
}

variable "cloud_run_service_image" {
  type = string
  description = "Cloud Run service docker image"
}

variable "redis_host" {
  type = string
  default = null
  description = "Redis host"
}

variable "sql_database_host" {
  type = string
  default = null
  description = "SQL Database host"
}

variable "sql_database_connection" {
  type = string
  default = null
  description = "SQL Database connection"
}

variable "sql_database_name" {
  type = string
  default = null
  description = "SQL Database name"
}

variable "redis_port" {
  type = string
  default = null
  description = "Redis port"
}

variable "backend_service_endpoint" {
  type = string
  default = null
  description = "Backend cloud run service endpoint"
}

variable "vpc_access_connector_id" {
  type = string
  default = null
  description = "VPC access connector ID"
}

variable "cloud_run_dependency" {
  type = any
  default = null
  description = "Cloud run dependency on Cloud SQL"
}

variable "vpc_access_egress" {
  type = string
  default = null
  description = "The outbound traffic to send through the VPC connector for this resource. Possible values: [all, all-traffic, private-ranges-only]"
}
