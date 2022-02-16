output "sql_passwords" {
  value     = random_password.sql_password.result
  sensitive = true
}