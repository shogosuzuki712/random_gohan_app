# NaniiTa
[![Image from Gyazo](https://i.gyazo.com/f4388e80b2f1cd7cbdac3fa39513b268.jpg)](https://gyazo.com/f4388e80b2f1cd7cbdac3fa39513b268)

```
Aさん）ごはん何食べる？

Bさん）なんでもいいよ？

Aさん）ん〜、どうしよう…
```
日常でよくある会話ですが、なかなか決めれずストレスに感じた事ありませんか？<br>
このような、`何食べる問題`を解決します。<br>
<br>

# アプリケーションのURL

http://54.64.237.128/

| テストアカウント | |
| - | - |
| email | tanaka@tarou |
| password | tanaka5tarou |
<br>

# DEMO
### 投稿方法

`①テストアカウントでログイン`<br>
`②画面右上「シェア」ボタンを押下`<br>
`③投稿内容を入力して「保存する」ボタン押下`<br>
`④投稿完了`<br>
<br>
 [![Image from Gyazo](https://i.gyazo.com/c4a6d9e3488f9015b63ea0d10de59a56.gif)](https://gyazo.com/c4a6d9e3488f9015b63ea0d10de59a56)

---
### 検索方法

`テストアカウントでログイン`<br>
`画面右上「決める」ボタン押下`<br>
`検索結果が無作為に表示される`<br>
`表示されたものを食べる`<br>
<br>
[![Image from Gyazo](https://i.gyazo.com/837ea779aa9b2eabd821a474196da778.gif)](https://gyazo.com/837ea779aa9b2eabd821a474196da778)

---
# 機能一覧

| 機能 | 概要 |
| - | - |
| ユーザー管理機能 | 新規登録・ログイン・ログアウトが可能 |
| 投稿機能 | 画像付きで食べ物の投稿が可能 |
| 編集・削除機能 | 自身の投稿のみ編集・削除が可能 |
| 投稿一覧表示機能 | ログイン時のみトップページに投稿一覧が表示 |
| 検索機能 | 全ての投稿から無作為に食べ物（検索結果）を表示 |
| ユーザー詳細表示機能 | 各ユーザーの投稿一覧を表示 |
| お問い合わせ機能 | ユーザーの声をGmailで受信可能 |
<br>

### Gmail受信BOX
[![Image from Gyazo](https://i.gyazo.com/5d3510e2fc18839c4158d40d0f25e764.png)](https://gyazo.com/5d3510e2fc18839c4158d40d0f25e764)
<br>
<br>

# 制作背景

誰もが食事の時間に何を食べるか悩んだ経験があると思っています。<br>
実際、私も一人暮らしをしていた頃は毎食何を食べようか悩み、ストレスを感じた経験があります。<br>
「何を食べるか考える時間」、「ストレス」、「消費する脳のエネルギー」は積み上っていく一方なので<br>
歯止めをかけたい！<br>
そんな思いから`NaniiTa`を制作しました。<br>
<br>

# 工夫したポイント

- 色使いを工夫しました。寒色系の色は食欲を損なので、暖色でカラーを整えました。<br>
- レスポンシブデザインを実装しました。スマホ、タブレット、PCそれぞれに適応したviewが表示できます。<br>
- JavaScriptにて画像のフェードイン表示とアコーディオンメニューの実装に挑戦したこと。<br>
<br>

# 使用技術（開発環境）

## バックエンド

Ruby,Ruby on Rails

---
## フロントエンド

HTML,CSS,JavaScript

---
## データベース

MySQL,SequelPro

---
## インフラ

AWS(EC2),Capistrano

---
## Webサーバ（本番環境）

Nginx

---
## アプリケーションサーバ（本番環境）

Unicorn

---
## ソース管理

GitHub,GitHubDesktop

---
## テスト

RSpec

---
## エディタ

Visual Studio Code

---

# 実装予定の機能

- CircleCI実装
- Docker実装
- タグ付け機能
- タグ検索機能
- いいね機能<br>
<br>

# テーブル設計

## usersテーブル
|  Column              |  Type     |  Option                     |
|  ------------------  |  -------  |  -------------------------  |
|  nickname            |  string   |  null: false                |
|  email               |  string   |  null: false, unique: true  |
|  encrypted_password  |  string   |  null: false                |

### Association
- has_many :tweets<br>
<br>
<br>
<br>

## tweetsテーブル
|  Column              |  Type        |  Option                     |
|  ------------------  |  ----------  |  -------------------------  |
|  title               |  string      |  null: false                |
|  text                |  text        |  null: false                |
|  user                |  references  |  foreign_key: true          |

### Association
- belongs_to :user<br>
<br>
<br>
<br>

# 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/7497b2616a6d8b0aefc53e8fa34508a3.png)](https://gyazo.com/7497b2616a6d8b0aefc53e8fa34508a3)