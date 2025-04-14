
# VPCネットワークの作成
resource "google_compute_network" "my_network" {
  name                    = "<YOUR_NETWORK_NAME>"
  auto_create_subnetworks = false
}

# サブネットワークの作成
resource "google_compute_subnetwork" "my_subnet" {
  name          = "<YOUR_SUBNET_NAME>"
  network       = google_compute_network.my_network.name
  ip_cidr_range = "<YOUR_SUBNET_CIDR>"
}

# サブネットワークのルートネットワークアクセスの有効化
resource "google_compute_subnetwork_iam_binding" "my_subnet_iam" {
  project    = "<YOUR_PROJECT_ID>"
  region     = "<YOUR_REGION>"
  subnetwork = google_compute_subnetwork.my_subnet.self_link
  role       = "roles/compute.networkViewer"

  members = [
    "serviceAccount:service-${google_sql_database_instance.my_instance.project_number}@gcp-sa-cloudsql.iam.gserviceaccount.com"
  ]
}
