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
  type        = string
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [ "MYSQL_5_6",
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
        "SQLSERVER_2019_EXPRESS",
        "SQLSERVER_2019_WEB"
               ],
   "description": "The MySQL, PostgreSQL or SQL Server version to use."
}
EOT
}
    
variable "region" {
  type        = string
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [ "asia-east1",
             "asia-east2",
             "asia-northeast1",
             "asia-northeast2",
            "asia-northeast3",
            "asia-south1",
            "asia-south2",
            "asia-southeast1",
            "asia-southeast2",
            "australia-southeast1",
            "australia-southeast2",
            "europe-central2",
            "europe-north1",
            "europe-west1",
            "europe-west2",
            "europe-west3",
            "europe-west4",
            "europe-west6",
            "northamerica-northeast1",
            "northamerica-northeast2",
            "southamerica-east1",
            "southamerica-west1",
            "us-central1",
            "us-east1",
            "us-east4",
            "us-west1",
            "us-west2",
            "us-west3",
            "us-west4"      
               ],
   "description": "The region the instance will be created at"
}
EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [
  "true",
  "false"
   ],
   "default":true
   "description": "it determines if the DB server is protected against deletion through Terraform."
}
EOT
}
variable "tier" {
  type        = string
  description = "The machine type to use"
  
}

variable "availability_type" {
  type        = string
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [  "REGIONAL",
              "ZONAL"
   ],
   "description": "The availability type of the Cloud SQL instance"
}
EOT
}

variable "disk_size" {
  description = "The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased"
  type        = string
}

variable "disk_autoresize" {
  type        = bool
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [  "true",
              "false"
   ],
   "description": "Configuration to increase storage size automatically"
}
EOT
}

variable "backup_enabled" {
  type        = bool
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [  "true",
              "false"
   ],
   "description": "True if backup configuration is enabled"
}
EOT
}

variable "binary_log_enabled" {
  type        = bool
  description = <<-EOT
  {
   "type": "json",
   "purpose": "autocomplete",
   "data": [  "true",
              "false"
   ],
   "description": "True if binary_log is enabled"
}
EOT
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
