module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "13.0.0"
  disable_services_on_destroy = false

  project_id  = var.project

  activate_apis = [
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}

resource "google_compute_network" "main" {
  provider                = google-beta
  name                    = var.compute_network_name
  auto_create_subnetworks = true
  project                 = var.project
}

resource "google_compute_global_address" "main" {
  name          = "${var.compute_network_name}-vpc-address"
  provider      = google-beta
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main.name
  project       = var.project
}

resource "google_service_networking_connection" "main" {
  network                 = google_compute_network.main.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.main.name]
}

resource "google_vpc_access_connector" "main" {
  provider       = google-beta
  project        = var.project
  name           = "${var.compute_network_name}-vpc-cx"
  ip_cidr_range  = "10.8.0.0/28"
  network        = google_compute_network.main.name
  region         = var.region
  max_throughput = 300
}
