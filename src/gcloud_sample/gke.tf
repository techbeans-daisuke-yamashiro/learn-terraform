# GKEクラスタの作成
resource "google_container_cluster" "my_cluster" {
  name     = "<YOUR_CLUSTER_NAME>"
  location = "<YOUR_LOCATION>"

  initial_node_count = 1

  # ノードプールの設定
  node_pool {
    name               = "<NODE_POOL_NAME>"
    initial_node_count = 1

    # ノードのマシンタイプ
    node_config {
      machine_type = "<MACHINE_TYPE>"
    }

    # 必要に応じて追加のノード設定を指定できます
    # ...

    # 追加のタグを指定できます（例: Firewallルールで使用するため）
    # tags = ["<TAG1>", "<TAG2>", ...]
  }

  # 必要に応じて追加のクラスタ設定を指定できます
  # ...

  # 追加のネットワークポリシーを指定できます
  # network_policy {
  #   enabled = true
  # }

  # クラスタマスタの認証情報を管理するためのクライアント証明書を有効にする場合
  # master_auth {
  #   client_certificate_config {
  #     issue_client_certificate = true
  #   }
  # }

  # 追加のメタデータを指定できます（例: ラベルなど）
  # additional_labels = {
  #   "key" = "value"
  # }
}

# GKEクラスタのKubeconfigファイルの生成
data "google_container_cluster" "my_cluster" {
  name     = google_container_cluster.my_cluster.name
  location = google_container_cluster.my_cluster.location

  project = "<YOUR_PROJECT_ID>"
}

resource "local_file" "kubeconfig" {
  filename = "<LOCAL_KUBECONFIG_FILE_PATH>"
  content  = data.google_container_cluster.my_cluster.master_auth[0].kubeconfig
}

# GKEデプロイメントの作成
resource "kubernetes_deployment" "my_deployment" {
  metadata {
    name = "<YOUR_DEPLOYMENT_NAME>"
    labels = {
      app = "<YOUR_APP_LABEL>"
    }
  }

  spec {
    replicas = var.deployment_replicas

    selector {
      match_labels = {
        app = "<YOUR_APP_LABEL>"
      }
    }

    template {
      metadata {
        labels = {
          app = "<YOUR_APP_LABEL>"
        }
      }

      spec {
        container {
          name  = "<YOUR_CONTAINER_NAME>"
          image = "<YOUR_CONTAINER_IMAGE>"
          # その他のコンテナ設定
          # ...
        }
      }
    }
  }
}

# GKEサービスの作成
resource "kubernetes_service" "my_service" {
  metadata {
    name = "<YOUR_SERVICE_NAME>"
  }

  spec {
    selector = {
      app = "<YOUR_APP_LABEL>"
    }

    port {
      port        = var.service_port
      target_port = var.service_target_port
    }
  }
}
