output "service_endpoint" {
  value = google_cloud_run_service.main.status[0].url
}

output "service_account_full_name" {
  value = "${google_service_account.runsa.account_id}@${var.project}.iam"
}