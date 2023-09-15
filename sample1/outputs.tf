output "gcs" {
  value = google_storage_bucket.test.url
  description = "Created bucket"
}
