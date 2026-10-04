# sinatra-app-ruby-practice

Sinatraで作成したシンプルなメモ帳アプリです。フィヨルドブートキャンプの「SinatraでシンプルなWebアプリを作ろう」の課題として作成しました。

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
- JSON(データ保存)

## ローカルでの起動方法

### 1. リポジトリをクローン

    git clone https://github.com/あなたのユーザー名/sinatra-app-ruby-practice.git
    cd sinatra-app-ruby-practice

### 2. Bundlerで必要なGemをインストール

    bundle install

### 3. アプリを起動

    bundle exec ruby app.rb

### 4. ブラウザでアクセス

以下のURLにアクセスしてください。

    http://localhost:4567/memos
