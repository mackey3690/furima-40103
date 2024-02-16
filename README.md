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

## purchases テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| user(FK)           | references | null: false, foreign_key: true |
| item(FK)           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping

## shippings テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| post_code           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| house_number       | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| purchase(FK)       | references | null: false, foreign_key: true |

### Association


- belongs_to :purchase
