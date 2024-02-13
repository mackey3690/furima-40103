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

- has_many :items
- has_many :purchases
- has_one  :shipping

## items テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| price              | integer    | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_change_id | integer    | null: false                    |
| user(FK)           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :purchase
- has_one    :shipping

## purchases テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| user(FK)           | references | null: false, foreign_key: true |
| item(FK)           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many :shippings

## shippings テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| postcode           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| housenumber        | string     | null: false                    |
| building           | string     | null: false                    |
| purchases(FK)      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :purchase
