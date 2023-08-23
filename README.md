# gitlab-on-ec2-with-docker

## 概要

`gitlab-on-ec2-with-docker` は、Dockerを使用してAmazon EC2上にGitLabインスタンスを迅速にデプロイするための設定を提供します。このリポジトリには、`full-configuration` と `minimal-configuration` の2つの設定オプションが含まれており、ユーザーのニーズに合わせてGitLabインスタンスをカスタマイズすることができます。

## 前提条件

- **Amazon EC2インスタンス**: セキュリティグループやVPCを適切に設定してください。
  
- **Docker**: Amazon EC2インスタンス上でインストールおよび実行が必要です。

- **Docker Compose**: GitLabコンテナのオーケストレーションに使用します。

`gitlab_backup` スクリプトを適切に利用するためには、以下の条件が必要です。

- **AWS CLIのインストール**：このスクリプトは、データをAmazon S3にアップロードするためにAWS CLIを使用します。

    ```bash
    sudo apt install awscli
    ```

## 設定の種類

### 全機能設定 (`full-configuration`)

SMTP設定、SSL設定、バックアップ設定を含むカスタマイズオプションを提供します。
本番環境での利用を想定しています。

### 最小構成 (`minimal-configuration`)

GitLabインスタンスをデプロイするために必要な最小限の設定のみを提供します。
テスト環境や小規模な利用に最適です。

## 使い方

1. EC2インスタンスにSSH接続します。
2. `gitlab-on-ec2-with-docker` リポジトリをクローンします。
3. リポジトリのディレクトリに移動します。
4. お好みに応じて `full-configuration` または `minimal-configuration` ディレクトリに移動します。
5. GitLabコンテナを起動するために次のコマンドを実行します。

```bash
   docker-compose up -d
```

## その他

### gitlab_backupについて

`gitlab_backup` はGitLabの設定やデータを定期的にバックアップし、Amazon S3へアップロードするスクリプトです。

バックアップを定期実行するための設定を行いたい場合は、以下のコマンドを使用してください。

```bash
crontab -e
```

## 作者

[@konta478310](https://twitter.com/konta478310)

## ライセンス

[MIT](http://TomoakiTANAKA.mit-license.org)</blockquote>