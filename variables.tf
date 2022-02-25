variable "db_root_username" {
  type        = string
  description = "The root username for the database instance"
}

variable "network_id" {
  description = "The id of the vpc"
  type        = string
}

variable "instance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "database_version" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
            "MYSQL_5_6",
            "MYSQL_5_7",
            "MYSQL_8_0",
            "POSTGRES_9_6",
            "POSTGRES_10",
            "POSTGRES_11",
            "POSTGRES_12",
            "POSTGRES_13",
            "SQLSERVER_2017_STANDARD",
            "SQLSERVER_2017_ENTERPRISE",
            "SQLSERVER_2017_EXPRESS",
            "SQLSERVER_2017_WEB",
            "SQLSERVER_2019_STANDARD",
            "SQLSERVER_2019_ENTERPRISE",
            "SQLSERVER_2019_STANDARD",
            "SQLSERVER_2019_EXPRESS",
            "SQLSERVER_2019_WEB"
            ],
     "description": "The MySQL, PostgreSQL or SQL Server version to use."
  }
EOT 
  type        = string
}

variable "region" {
  description = <<-EOT
  {
   "type": "api",
   "purpose": "autocomplete",
   "data": "/api/v1/autocomplete/regions",
   "description": "regions used for deployment"
}
EOT
  type        = string
}

variable "deletion_protection" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "true",
  "false"
   ],
   "description": "Whether or not to allow Terraform to destroy the instance"
   }
EOT 
  type        = bool
  default     = false
}

variable "tier" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
      "db-f1-micro",
      "db-g1-small",
      "db-n1-standard-1",
      "db-n1-standard-2",
      "db-n1-standard-4",
      "db-n1-standard-8",
      "db-n1-standard-16",
      "db-n1-standard-32",
      "db-n1-standard-64",
      "db-n1-standard-96",
      "db-n1-highmem-2",
      "db-n1-highmem-4",
      "db-n1-highmem-8",
      "db-n1-highmem-16",
      "db-n1-highmem-32",
      "db-n1-highmem-64",
      "db-n1-highmem-96"
     ],
   "description": "The machine tier to use"
   }
EOT 
  type        = string
}

variable "availability_type" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "REGIONAL",
  "ZONAL"
   ],
   "description": "The availability type of the Cloud SQL instance"
   }
EOT 
  type        = string
}

variable "disk_size" {
  description = "The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased"
  type        = string
}

variable "disk_autoresize" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "true",
  "false"
   ],
   "description": "Configuration to increase storage size automatically"
   }
EOT 
  type        = bool
}

variable "backup_enabled" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "true",
  "false"
   ],
   "description": "True if backup configuration is enabled"
   }
EOT 
  type        = bool
}

variable "binary_log_enabled" {
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "true",
  "false"
   ],
   "description": "True if binary log is enabled"
EOT 
  type        = bool
}

variable "backup_start_time" {
  description = "HH:MM format time indicating when backup configuration starts"
  type        = string
}

variable "database_flags" {
  description = "The id of the vpc"
  type = list(object({
    name  = string
    value = string
  }))
}

variable "insights_config" {
  description = "The id of the vpc"
  type = list(object({
    query_insights_enabled  = bool
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  }))
}

variable "maintenance_window" {
  description = "Subblock for instances declares a one-hour maintenance window when an Instance can automatically restart to apply updates"
  type = list(object({
    maintenance_window_day          = number
    maintenance_window_hour         = number
    maintenance_window_update_track = string
  }))
}

variable "shared_vpc_project_id" {
  description = "Shared VPC project"
  type        = string
}

variable "project_id" {
  description = "The project where the database lives"
  type        = string
}

variable "private_ip_address_name" {
  description = "The name of the static private ip for the database"
  type        = string
}

variable "reserved_peering_ranges" {
  description = "List of peering ranges"
  type        = list(string)
}
variable "tags" {
  type        = list(string)
  description = "this will be used for tagging resources."
}
