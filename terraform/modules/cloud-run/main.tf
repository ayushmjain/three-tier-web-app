data "google_project" "project" {
  project_id = var.project
}

locals {
  run_roles = [
    "roles/cloudsql.instanceUser",
    "roles/cloudsql.client",
    "roles/spanner.databaseUser",
  ]
}

module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "13.0.0"
  disable_services_on_destroy = false

  project_id  = var.project
  enable_apis = true

  activate_apis = [
    "compute.googleapis.com",
    "cloudapis.googleapis.com",
    "cloudbuild.googleapis.com",
    "storage.googleapis.com",
    "run.googleapis.com",
  ]
}

resource "google_service_account" "runsa" {
  project      = var.project
  account_id   = "${var.cloud_run_sa_id}-run-sa"
  display_name = "Service Account for Cloud Run"
}

resource "google_project_iam_member" "allrun" {
  for_each = toset(local.run_roles)
  project  = data.google_project.project.number
  role     = each.key
  member   = "serviceAccount:${google_service_account.runsa.email}"
}

resource "google_cloud_run_service" "main" {
  name     = var.cloud_run_service_name
  provider = google-beta
  location = var.region
  project  = var.project

  template {
    spec {
      service_account_name = google_service_account.runsa.email
      containers {
        image = var.cloud_run_service_image
        ports {
          container_port = 80
        }
        env {
          name  = "redis_host"
          value = var.redis_host
        }
        env {
          name  = "db_host"
          value = var.sql_database_host
        }
        env {
          name  = "db_user"
          value = google_service_account.runsa.email
        }
        env {
          name  = "db_conn"
          value = var.sql_database_connection
        }
        env {
          name  = "db_name"
          value = var.sql_database_name
        }
        env {
          name  = "redis_port"
          value = var.redis_port
        }
        env {
          name  = "ENDPOINT"
          value = var.backend_service_endpoint
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "8"
        "run.googleapis.com/cloudsql-instances"   = var.sql_database_connection
        "run.googleapis.com/client-name"          = "terraform"
        "run.googleapis.com/vpc-access-egress"    = var.vpc_access_egress
        "run.googleapis.com/vpc-access-connector" = var.vpc_access_connector_id
      }
    }
  }
//  metadata {
//    labels = var.labels
//  }
  autogenerate_revision_name = true
  depends_on = [
    var.cloud_run_dependency
  ]
}

resource "google_cloud_run_service_iam_member" "noauth_api" {
  location = google_cloud_run_service.main.location
  project  = google_cloud_run_service.main.project
  service  = google_cloud_run_service.main.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
