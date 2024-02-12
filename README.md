# テーブル設計

## users テーブル

| Column             | Type    | Option                     |
| ------------------ | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| last_name          | string  | null: false                |
| first_name         | string  | null: false                |
| last_name_kana     | string  | null: false                |
| first_name_kana    | string  | null: false                |
| date_of_birth      | date    | null: false                |

### Association

- has_many :item
- has_one  :purchase

## items テーブル

| Column             | Type      | Option                     |
| ------------------ | --------- | -------------------------- |
| name               | text      | null: false                |
| price              | integer   | null: false                |
| description        | text      | null: false                |
| category_id        | integer   | null: false                |
| condition_id       | integer   | null: false                |
| shipping_date_id   | integer   | null: false                |
| prefecture_id      | integer   | null: false                |
| shipping_change_id | integer   | null: false                |
| user(FK)           | reference | foreign_key: true          |

### Association

- belongs_to :user
- has_one  :purchase

## purchases テーブル

| Column             | Type      | Option                     |
| ------------------ | --------- | -------------------------- |
| user(FK)           | reference | foreign_key: true          |
| item(FK)           | reference | foreign_key: true          |

### Association

- belong_to :user
- belong_to :item

