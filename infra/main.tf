resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "plan" {
  name                = var.app_service_plan
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DATABASE_HOST"                       = azurerm_sql_server.sql.fully_qualified_domain_name
    "DATABASE_NAME"                       = azurerm_sql_database.db.name
    "DATABASE_USER"                       = var.sql_admin_user
    "DATABASE_PASSWORD"                   = var.sql_admin_password
  }
}

resource "azurerm_sql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  version                       = "12.0"
  administrator_login           = var.sql_admin_user
  administrator_login_password  = var.sql_admin_password
}

resource "azurerm_sql_database" "db" {
  name                = "demoappdb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name
  sku_name            = "S0"
}

output "webapp_url" {
  value = azurerm_app_service.app.default_site_hostname
}
