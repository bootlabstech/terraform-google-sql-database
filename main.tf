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
  project  = var.project_id
  instance = google_sql_database_instance.instance.name
  password = random_password.sql_password.result
}

# resource "google_compute_global_address" "private_ip_address" {

#   name          = var.private_ip_address_name
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   project       = var.shared_vpc_project
#   prefix_length = 16
#   network       = var.network_id
# }

# resource "google_compute_address" "private_ip_address" {
#   count = "${var.create_peering_range && var.subnetwork_id != "" ? 1 : 0}"
#   name          = var.private_ip_address_name
#   prefix_length = 16
#   project       = var.shared_vpc_project_id
#   subnetwork    = var.subnetwork_id
#   address_type  = "INTERNAL"
#   purpose       = "VPC_PEERING"
# }

# resource "google_service_networking_connection" "private_vpc_connection" {
#   count = "${var.create_peering_range ? 1 : 0}"
#   network                 = var.network_id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_address.private_ip_address.name]
# }

# resource "google_service_networking_connection" "private_vpc_connection" {
#   network                 = var.network_id
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = var.reserved_peering_ranges
# }

resource "google_sql_database_instance" "instance" {
  #ts:skip=AC_GCP_0003 DB SSL needs application level changes
  provider            = google-beta
  name                = "${var.instance_name}-${random_string.sql_server_suffix.id}"
  database_version    = var.database_version
  region              = var.region
  project             = var.project_id
  deletion_protection = var.deletion_protection
  root_password       = random_password.sql_password.result
  encryption_key_name = var.encryption_key_name == "" ? null : var.encryption_key_name

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_autoresize   = var.disk_autoresize

    backup_configuration {
      enabled            = var.backup_enabled
      start_time         = var.backup_start_time
      binary_log_enabled = var.binary_log_enabled
    }

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.network_id
    }

    dynamic "database_flags" {
      for_each = var.database_flags
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
    #google_service_networking_connection.private_vpc_connection,
    google_project_service_identity.sa
  ]

}

//Create this in the first run, allow google_sql_database_instance to fail. 
//Then add iam binding for this SA in keyring rerun this module again.
resource "google_project_service_identity" "sa" {
  provider = google-beta

  project = var.project_id
  service = "sqladmin.googleapis.com"
}