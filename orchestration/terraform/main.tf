module "network" {
  source               = "./modules/compute-network"
  compute_network_name = var.network_compute_network_name
  project              = var.project
  region               = var.region
}
module "cloud_run_api" {
  source                   = "./modules/cloud-run"
  redis_host               = module.redis.redis_host
  redis_port               = module.redis.redis_port
  sql_database_connection  = module.sql_database.database_connection_name
  sql_database_host        = module.sql_database.database_host
  sql_database_name        = module.sql_database.database_name
  backend_service_endpoint = var.cloud_run_api_backend_service_endpoint
  vpc_access_egress        = var.cloud_run_api_vpc_access_egress
  project                  = var.project
  cloud_run_service_name   = var.cloud_run_api_cloud_run_service_name
  cloud_run_dependency     = module.sql_database.cloud_run_dependency
  vpc_access_connector_id  = module.network.vpc_access_connector_id
  region                   = var.region
  cloud_run_sa_id          = var.cloud_run_api_cloud_run_sa_id
  cloud_run_service_image  = var.cloud_run_api_cloud_run_service_image
}
module "sql_database" {
  source             = "./modules/cloud-sql"
  project            = var.project
  region             = var.region
  zone               = var.zone
  database_name      = var.sql_database_database_name
  network_name       = module.network.network_name
  sql_dependency     = module.network.sql_dependency
  database_user_name = module.cloud_run_api.service_account_full_name
}
module "redis" {
  source       = "./modules/redis"
  network_name = module.network.network_name
  project      = var.project
  region       = var.region
  zone         = var.zone
  redis_name   = var.redis_redis_name
}
module "cloud_run_fe" {
  source                   = "./modules/cloud-run"
  region                   = var.region
  sql_database_host        = var.cloud_run_fe_sql_database_host
  sql_database_name        = var.cloud_run_fe_sql_database_name
  cloud_run_dependency     = var.cloud_run_fe_cloud_run_dependency
  vpc_access_egress        = var.cloud_run_fe_vpc_access_egress
  project                  = var.project
  cloud_run_sa_id          = var.cloud_run_fe_cloud_run_sa_id
  cloud_run_service_image  = var.cloud_run_fe_cloud_run_service_image
  cloud_run_service_name   = var.cloud_run_fe_cloud_run_service_name
  redis_port               = var.cloud_run_fe_redis_port
  backend_service_endpoint = module.cloud_run_api.service_endpoint
  redis_host               = var.cloud_run_fe_redis_host
  sql_database_connection  = var.cloud_run_fe_sql_database_connection
  vpc_access_connector_id  = var.cloud_run_fe_vpc_access_connector_id
}
