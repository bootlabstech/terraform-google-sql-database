resource "random_string" "sql_server_suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
  number  = true
}

resource "random_password" "sql_password" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  number           = true
  override_special = "-_!#^~%@"
}

resource "google_sql_user" "users" {
  name     = var.db_root_username
  project       = var.project
  instance = google_sql_database_instance.instance.name
  password = random_password.sql_password.result
}

resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_address_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  project       = var.shared_vpc_project
  prefix_length = 16
  network       = var.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "instance" {
  name             = "${var.instance_name}-${random_string.sql_server_suffix.id}"
  database_version = var.database_version
  region           = var.region
  project       = var.project
  deletion_protection  = var.deletion_protection

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_autoresize   = var.disk_autoresize

    backup_configuration {
      enabled    = var.backup_enabled
      start_time = var.backup_start_time
      binary_log_enabled = var.binary_log_enabled
    }

    ip_configuration {
      ipv4_enabled    = "true"
      private_network = var.network_id
    }

    dynamic "database_flags" {
      for_each  = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    dynamic "insights_config" {
      for_each = var.insights_config
      content {
        query_insights_enabled  = insights_config.value.query_insights_enabled
        query_string_length     = insights_config.value.query_string_length
        record_application_tags = insights_config.value.record_application_tags
        record_client_address   = insights_config.value.record_client_address
      }
    }

    dynamic "maintenance_window" {
      for_each = var.maintenance_window
      content {
        day          = maintenance_window.value.maintenance_window_day
        hour         = maintenance_window.value.maintenance_window_hour
        update_track = maintenance_window.value.maintenance_window_update_track
      }
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]

}
