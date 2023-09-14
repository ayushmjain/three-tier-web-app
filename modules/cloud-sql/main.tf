module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "13.0.0"
  disable_services_on_destroy = false

  project_id  = var.project

  activate_apis = [
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
  ]
}

# Handle Database
resource "google_sql_database_instance" "main" {
  name             = "${var.database_name}-instance"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project

  settings {
    tier                  = "db-g1-small"
    disk_autoresize       = true
    disk_autoresize_limit = 0
    disk_size             = 10
    disk_type             = "PD_SSD"
    ip_configuration {
      ipv4_enabled    = var.network_name != null ? false : true
      private_network = var.network_name != null ? "projects/${var.project}/global/networks/${var.network_name}" : null
    }
    location_preference {
      zone = var.zone
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
  deletion_protection = false
  depends_on = [var.sql_dependency]
}


resource "google_sql_user" "main" {
  project         = var.project
  name            = var.database_user_name
  type            = "CLOUD_IAM_SERVICE_ACCOUNT"
  instance        = google_sql_database_instance.main.name
  deletion_policy = "ABANDON"
}

resource "google_sql_database" "database" {
  project         = var.project
  name            = var.database_name
  instance        = google_sql_database_instance.main.name
  deletion_policy = "ABANDON"
}