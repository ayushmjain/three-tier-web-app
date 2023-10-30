output "database_connection_name" {
  value = google_sql_database_instance.main.connection_name
}

output "database_host" {
  value = google_sql_database_instance.main.ip_address[0].ip_address
}

output "database_name" {
  value = google_sql_database.database.name
}

output "cloud_run_dependency" {
  value = {}
  depends_on = [google_sql_user.main, google_sql_database.database]
}
