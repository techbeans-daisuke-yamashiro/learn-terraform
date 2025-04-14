## 事前準備
### 作業用コンテナの用意

### Compute Engine APIの有効化
下記のAPIを有効化する必要があります。
- Compute Engine
- Cloud DNS

Webコンソールからやってもいいですが、CLIが早いです。

```bash
$ gcloud services enable compute.googleapis.com
$ gcloud services enable dns.googleapis.com
```

### ドメイン名の確認
Google Cloud の仕様上、[バケット名にドメイン名を紐づける場合、そのドメインの所有権を確認する必要があります。
](https://cloud.google.com/storage/docs/domain-name-verification?hl=ja)

ドメイン名をバケット名につけるときの判定基準
- 構文的に有効な DNS 名である（たとえば、bucket..example.com はドットが連続しているため無効です）。
- 末尾が現在認められているトップレベル ドメイン（.com など）である。

[GoogleSearchコンソール](https://search.google.com/search-console/users?hl=ja)からサイトをデプロイしたい
ドメインを「プロパティを追加」から追加してください。「確認用のTXTレコードを発行してもらってそれをCloudDNS側に登録する」作業が必要になります。