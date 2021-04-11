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
