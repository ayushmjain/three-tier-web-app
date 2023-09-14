module "network" {
  source               = "./modules/compute-network"
  project              = var.project
  region               = var.region
  compute_network_name = var.network_compute_network_name
}
module "cloud-run-api" {
  source                   = "./modules/cloud-run"
  region                   = var.region
  redis_host               = module.redis.redis_host
  sql_database_connection  = module.sql-database.database_connection_name
  cloud_run_dependency     = module.sql-database.cloud_run_dependency
  project                  = var.project
  vpc_access_egress        = var.cloud-run-api_vpc_access_egress
  sql_database_host        = module.sql-database.database_host
  sql_database_name        = module.sql-database.database_name
  vpc_access_connector_id  = module.network.vpc_access_connector_id
  backend_service_endpoint = var.cloud-run-api_backend_service_endpoint
  cloud_run_sa_id          = var.cloud-run-api_cloud_run_sa_id
  redis_port               = module.redis.redis_port
  cloud_run_service_image  = var.cloud-run-api_cloud_run_service_image
  cloud_run_service_name   = var.cloud-run-api_cloud_run_service_name
}
module "sql-database" {
  source             = "./modules/cloud-sql"
  network_name       = module.network.network_name
  sql_dependency     = module.network.sql_dependency
  database_user_name = module.cloud-run-api.service_account_full_name
  project            = var.project
  region             = var.region
  zone               = var.zone
  database_name      = var.sql-database_database_name
}
module "redis" {
  source       = "./modules/redis"
  network_name = module.network.network_name
  project      = var.project
  region       = var.region
  zone         = var.zone
  redis_name   = var.redis_redis_name
}
module "cloud-run-fe" {
  source                   = "./modules/cloud-run"
  cloud_run_dependency     = var.cloud-run-fe_cloud_run_dependency
  cloud_run_service_image  = var.cloud-run-fe_cloud_run_service_image
  redis_host               = var.cloud-run-fe_redis_host
  region                   = var.region
  sql_database_connection  = var.cloud-run-fe_sql_database_connection
  vpc_access_connector_id  = var.cloud-run-fe_vpc_access_connector_id
  vpc_access_egress        = var.cloud-run-fe_vpc_access_egress
  backend_service_endpoint = module.cloud-run-api.service_endpoint
  cloud_run_sa_id          = var.cloud-run-fe_cloud_run_sa_id
  cloud_run_service_name   = var.cloud-run-fe_cloud_run_service_name
  redis_port               = var.cloud-run-fe_redis_port
  sql_database_host        = var.cloud-run-fe_sql_database_host
  sql_database_name        = var.cloud-run-fe_sql_database_name
  project                  = var.project
}
