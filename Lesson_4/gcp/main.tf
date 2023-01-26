provider "google" {
  project  = "playground-s-11-17017b5a"
  credentials = file("./creds.json")
}


locals {
    instance_amount = 3
}

resource "random_string" "luboi" {
  count   = local.instance_amount
  length  = 5
  special = false
  upper = false
}

resource "google_compute_instance" "aktan" {
  count        = local.instance_amount
  name         = "ant-${random_string.luboi[count.index].result}"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  
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
