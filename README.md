# アプリケーション名

NaniiTa

# 概要
食べるごはんを決めてくれるアプリケーションを制作しました。

```
Aさん）ごはん何食べる？

Bさん）なんでもいいよ？
```
日常でよくある会話ですが、なかなか決めれずストレスに感じた事ありませんか？

このような悩みを解決します。

# アプリケーションの概要
実装した機能としては5点あります。

ユーザー管理機能、投稿機能、編集機能、削除機能、検索機能です。

ユーザー登録すると投稿機能や検索機能が使用できます。検索機能を使用すると、全ての投稿の中から1つランダム表示します。

また、自身の投稿は編集・削除することができます。

投稿された画像を押下すると、投稿ユーザーの投稿一覧が表示できます。

# アプリケーションのURL

54.64.237.128

# テスト用アカウント
【ユーザーA】

Email: tanaka@tarou

Password: tanaka5tarou

【ユーザーB】

Email: satou@tarou

Password: satou5tarou

# 利用方法
- WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。

- 接続先およびログイン情報については、上記の通りです。

- 同時に複数の方がログインしている場合に、ログインできない可能性があります。

- 投稿方法

  - テストアカウントでログイン→「シェア」ボタン押下→投稿情報入力→「保存する」押下→投稿完了です。

- 検索方法

  - テストアカウントでログイン→「決める」ボタン押下→検索結果が表示されます。

# 制作背景（意図）

誰もが食事の時間に何を食べるか悩んだ経験があると思っています。

実際、私も一人暮らしをしていた頃は食事の時間に何を食べようか悩み、何度かストレスを感じた経験がございます。

そこで、一人暮らしの方、主婦をターゲットとし、食事の時間に何を食べればよいか決めてくれるアプリケーションがあれば便利だなと思い制作しました。

# DEMO

## ユーザー管理機能

- トップページ【ログアウト状態】


[![Image from Gyazo](https://i.gyazo.com/f4388e80b2f1cd7cbdac3fa39513b268.jpg)](https://gyazo.com/f4388e80b2f1cd7cbdac3fa39513b268)


- 新規登録ページ

[![Image from Gyazo](https://i.gyazo.com/5ce4ee2456add429bd92e28033040105.png)](https://gyazo.com/5ce4ee2456add429bd92e28033040105)

- トップページ【ログイン状態】

[![Image from Gyazo](https://i.gyazo.com/fb0643b8cb45a544b3769338b171aeee.jpg)](https://gyazo.com/fb0643b8cb45a544b3769338b171aeee)

---
## 投稿機能

- 投稿ページ

[![Image from Gyazo](https://i.gyazo.com/bb6005725c1b2f99045a6a5eb874284b.png)](https://gyazo.com/bb6005725c1b2f99045a6a5eb874284b)

---
## 編集機能

- 編集ページ

[![Image from Gyazo](https://i.gyazo.com/f64324cd3019f34c7caf9eab37f98e70.gif)](https://gyazo.com/f64324cd3019f34c7caf9eab37f98e70)

--- 
## 削除機能

- 削除ページ

[![Image from Gyazo](https://i.gyazo.com/77432ba4bbf76413a5dd8cdbb49af167.gif)](https://gyazo.com/77432ba4bbf76413a5dd8cdbb49af167)

---
## 検索機能
- 検索ページ

[![Image from Gyazo](https://i.gyazo.com/8cd44549b714158eb02bcd8490774b35.gif)](https://gyazo.com/8cd44549b714158eb02bcd8490774b35)

# 工夫したポイント

- 色使いに留意しております。寒色系の色は食欲を抑制するので、暖色でデザインを行いました。

- レスポンシブデザインを採用しました。スマホ、タブレット、PCからアクセスしてもビューは崩れません。

# 使用技術（開発環境）

## バックエンド

Ruby,Ruby on Rails

---
## フロントエンド

HTML,CSS

---
## データベース

MySQL,SquelPro

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

# 実装予定の機能

- お気に入りボタン
- お気に入り保存機能
- お気に入りランダム検索機能

# テーブル設計

## usersテーブル
|  Column              |  Type     |  Option                     |
|  ------------------  |  -------  |  -------------------------  |
|  nickname            |  string   |  null: false                |
|  email               |  string   |  null: false, unique: true  |
|  encrypted_password  |  string   |  null: false                |

### Association
- has_many :tweets


## tweetsテーブル
|  Column              |  Type        |  Option                     |
|  ------------------  |  ----------  |  -------------------------  |
|  title               |  string      |  null: false                |
|  text                |  text        |  null: false                |
|  user                |  references  |  foreign_key: true          |

### Association
- belongs_to :user
