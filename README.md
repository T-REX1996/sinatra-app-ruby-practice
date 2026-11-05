# sinatra-app-ruby-practice

Sinatraで作成したシンプルなメモ帳アプリです。フィヨルドブートキャンプの「SinatraでシンプルなWebアプリを作ろう」の課題として作成しました。
データの保存先はPostgreSQLです。

## 機能

- メモの一覧表示
- メモの新規作成
- メモの詳細表示
- メモの編集
- メモの削除

## 使用技術

- Ruby
- Sinatra
- ERB
- PostgreSQL(`pg` gem)

## ローカルでの起動方法

### 前提

- Ruby と Bundler がインストールされていること
- PostgreSQL がインストールされ、起動していること
  - Ubuntu の場合: `sudo apt install postgresql libpq-dev`、`sudo service postgresql start`
  - `libpq-dev` は `pg` gem のビルドに必要です
- 現在のユーザー名と同名の PostgreSQL ロールがあり、パスワードなしで接続できること
  - 作成例: `sudo -u postgres createuser --superuser $USER`

### 1. リポジトリをクローン

    git clone https://github.com/あなたのユーザー名/sinatra-app-ruby-practice.git
    cd sinatra-app-ruby-practice

### 2. Bundlerで必要なGemをインストール

    bundle install

### 3. データベースとテーブルを作成

`db/schema.sql` にデータベース(`memo_app`)とテーブル(`memos`)の定義があります。

    psql -d postgres -f db/schema.sql

### 4. アプリを起動

    bundle exec ruby app.rb

PostgreSQL のポートが標準の 5432 でない場合は、`PGPORT` で指定してください。

    PGPORT=5433 bundle exec ruby app.rb

接続するデータベース名を変える場合は `DB_NAME` を指定します(未指定なら `memo_app`)。

### 5. ブラウザでアクセス

以下のURLにアクセスしてください。

    http://localhost:4567/memos

## データベース

| テーブル | カラム | 型 | 説明 |
| --- | --- | --- | --- |
| memos | id | SERIAL (PK) | メモID |
| | title | VARCHAR(255) | タイトル |
| | body | TEXT | 本文 |
| | created_at | TIMESTAMP | 作成日時 |

## ルーティング

| メソッド | パス | 内容 |
| --- | --- | --- |
| GET | /memos | 一覧 |
| GET | /memos/new | 新規作成フォーム |
| POST | /memos | 作成 |
| GET | /memos/:id | 詳細 |
| GET | /memos/:id/edit | 編集フォーム |
| PATCH | /memos/:id | 更新 |
| DELETE | /memos/:id | 削除 |

## 静的解析

    bundle exec rubocop
    bundle exec erb_lint --lint-all
