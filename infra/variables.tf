variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "rg-github-actions-demo"
}

variable "app_service_plan" {
  default = "asp-github-demo"
}

variable "app_service_name" {
  default = "webapp-github-demo"
}

variable "sql_server_name" {
  default = "sqlservergithubdemo"
}

variable "sql_admin_user" {
  default = "sqladminuser"
}

variable "sql_admin_password" {
  default = "StrongPassword@123!"
}
