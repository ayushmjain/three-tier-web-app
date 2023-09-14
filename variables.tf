variable "project" {
  type        = string
  description = "GCP Project"
}
variable "region" {
  type        = string
  description = "GCP Region"
}
variable "network_compute_network_name" {
  type        = string
  description = "Google compute network name"
}
variable "cloud-run-api_backend_service_endpoint" {
  type        = string
  description = "Backend cloud run service endpoint"
}
variable "cloud-run-api_cloud_run_sa_id" {
  type        = string
  description = "Cloud Run service account ID"
}
variable "cloud-run-api_cloud_run_service_image" {
  type        = string
  description = "Cloud Run service docker image"
}
variable "cloud-run-api_cloud_run_service_name" {
  type        = string
  description = "Cloud Run service name"
}
variable "cloud-run-api_vpc_access_egress" {
  type        = string
  description = "The outbound traffic to send through the VPC connector for this resource. Possible values: [all, all-traffic, private-ranges-only]"
}
variable "zone" {
  type        = string
  description = "GCP Zone"
}
variable "sql-database_database_name" {
  type        = string
  description = "Database name"
}
variable "redis_redis_name" {
  type        = string
  description = "Redis instance name"
}
variable "cloud-run-fe_cloud_run_sa_id" {
  type        = string
  description = "Cloud Run service account ID"
}
variable "cloud-run-fe_cloud_run_service_image" {
  type        = string
  description = "Cloud Run service docker image"
}
variable "cloud-run-fe_cloud_run_service_name" {
  type        = string
  description = "Cloud Run service name"
}
variable "cloud-run-fe_redis_host" {
  type        = string
  description = "Redis host"
}
variable "cloud-run-fe_redis_port" {
  type        = string
  description = "Redis port"
}
variable "cloud-run-fe_sql_database_connection" {
  type        = string
  description = "SQL Database connection"
}
variable "cloud-run-fe_sql_database_host" {
  type        = string
  description = "SQL Database host"
}
variable "cloud-run-fe_sql_database_name" {
  type        = string
  description = "SQL Database name"
}
variable "cloud-run-fe_vpc_access_connector_id" {
  type        = string
  description = "VPC access connector ID"
}
variable "cloud-run-fe_cloud_run_dependency" {
  type        = any
  description = "Cloud run dependency on Cloud SQL"
}
variable "cloud-run-fe_vpc_access_egress" {
  type        = string
  description = "The outbound traffic to send through the VPC connector for this resource. Possible values: [all, all-traffic, private-ranges-only]"
}
