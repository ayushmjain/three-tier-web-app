output "network_name" {
  value = google_compute_network.main.name
}

output "vpc_access_connector_id" {
  value = google_vpc_access_connector.main.id
}

output "sql_dependency" {
  value = {}
  depends_on = [google_service_networking_connection.main]
}