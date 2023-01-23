provider "google" {
  region      = "us-cetral1"
  credentials = "./creds.json"
}

resource "google_compute_instance" "gcp" {
  name         = "gcp"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
