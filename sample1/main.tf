resource "random_pet" "pet" {}

resource "google_storage_bucket" "test" {
  project                     = var.project_id
  name                        = "sample-${var.project_id}-${random_pet.pet.id}"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "content" {
  name    = "dynamic"
  content = "test-content"
  bucket  = google_storage_bucket.test.id
}
