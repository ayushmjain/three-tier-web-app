module "network" {
  source               = "git::https://github.com/ayushmjain/composition-modules.git//compute-network/v1"
  compute_network_name = var.network_compute_network_name
  project              = var.project
  region               = var.region
}
module "cloud-run-api" {
  source                   = "git::https://github.com/ayushmjain/composition-modules.git//cloud-run/v1"
  redis_host               = module.redis.redis_host
  redis_port               = module.redis.redis_port
  sql_database_connection  = module.sql-database.database_connection_name
  sql_database_host        = module.sql-database.database_host
  sql_database_name        = module.sql-database.database_name
  backend_service_endpoint = var.cloud-run-api_backend_service_endpoint
  vpc_access_egress        = var.cloud-run-api_vpc_access_egress
  project                  = var.project
  cloud_run_service_name   = var.cloud-run-api_cloud_run_service_name
  cloud_run_dependency     = module.sql-database.cloud_run_dependency
  vpc_access_connector_id  = module.network.vpc_access_connector_id
  region                   = var.region
  cloud_run_sa_id          = var.cloud-run-api_cloud_run_sa_id
  cloud_run_service_image  = var.cloud-run-api_cloud_run_service_image
}
module "sql-database" {
  source             = "git::https://github.com/ayushmjain/composition-modules.git//cloud-sql/v1"
  project            = var.project
  region             = var.region
  zone               = var.zone
  database_name      = var.sql-database_database_name
  network_name       = module.network.network_name
  sql_dependency     = module.network.sql_dependency
  database_user_name = module.cloud-run-api.service_account_full_name
}
module "redis" {
  source       = "git::https://github.com/ayushmjain/composition-modules.git//redis/v1"
  network_name = module.network.network_name
  project      = var.project
  region       = var.region
  zone         = var.zone
  redis_name   = var.redis_redis_name
}
module "cloud-run-fe" {
  source                   = "git::https://github.com/ayushmjain/composition-modules.git//cloud-run/v1"
  region                   = var.region
  sql_database_host        = var.cloud-run-fe_sql_database_host
  sql_database_name        = var.cloud-run-fe_sql_database_name
  cloud_run_dependency     = var.cloud-run-fe_cloud_run_dependency
  vpc_access_egress        = var.cloud-run-fe_vpc_access_egress
  project                  = var.project
  cloud_run_sa_id          = var.cloud-run-fe_cloud_run_sa_id
  cloud_run_service_image  = var.cloud-run-fe_cloud_run_service_image
  cloud_run_service_name   = var.cloud-run-fe_cloud_run_service_name
  redis_port               = var.cloud-run-fe_redis_port
  backend_service_endpoint = module.cloud-run-api.service_endpoint
  redis_host               = var.cloud-run-fe_redis_host
  sql_database_connection  = var.cloud-run-fe_sql_database_connection
  vpc_access_connector_id  = var.cloud-run-fe_vpc_access_connector_id
}
