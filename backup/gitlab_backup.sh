#!/bin/bash

# GitLabの設定をバックアップする
docker-compose exec gitlab gitlab-ctl backup-etc

# GitLabのデータをバックアップする
docker-compose exec gitlab gitlab-backup create

# 当日の日付を取得
TODAY=$(date +%Y_%m_%d)

# バックアップディレクトリから最新のファイルを見つける
BACKUP_FILE_TO_UPLOAD=$(ls -t /srv/gitlab/backups/ | head -n1)
FULL_PATH_BACKUP="/srv/gitlab/backups/${BACKUP_FILE_TO_UPLOAD}"

# config_backupディレクトリから最新のファイルを見つける
CONFIG_FILE_TO_UPLOAD=$(ls -t /srv/gitlab/config/config_backup/ | head -n1)
FULL_PATH_CONFIG="/srv/gitlab/config/config_backup/${CONFIG_FILE_TO_UPLOAD}"

# 各ディレクトリからのファイルが存在するかを確認して権限を変更後、アップロード
for FILE in ${FULL_PATH_BACKUP} ${FULL_PATH_CONFIG}
do
    if [[ ! -f ${FILE} ]]; then
        echo "No file found in the respective directory."
        continue
    fi

    # ファイルの読み取り権限を変更
    sudo chmod +r "${FILE}"

    # S3にアップロード
    aws s3 cp "${FILE}" s3://[BUCKET_NAME]/${TODAY}/
done
