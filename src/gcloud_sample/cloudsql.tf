# CloudSQLインスタンスの作成
resource "google_sql_database_instance" "my_instance" {
  name             = "<YOUR_INSTANCE_NAME>"
  region           = "<YOUR_REGION>"
  database_version = "MYSQL_5_7"

  settings {
    tier = "<YOUR_INSTANCE_TIER>"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.my_network.self_link

      # サブネットワークの指定
      require_ssl        = true
      ipv4_address_range = "<YOUR_IP_ADDRESS_RANGE>"
    }
  }
}
