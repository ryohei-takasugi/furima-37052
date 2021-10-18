## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| last_name_kana     | string | null: false |
| first_name         | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |


### Association

- has_many :orders
- has_many :items

## items テーブル

| Column              | Type       | Options                         |
| ------------------- | ---------- | ------------------------------- |
| name                | string     | null: false                     |
| info                | text       | null: false                     |
| category            | integer    | null: false                     |
| sales-status        | integer    | null: false                     |
| shipping-fee-status | integer    | null: false                     |
| prefecture          | integer    | null: false                     |
| scheduled-delivery  | integer    | null: false                     |
| price               | integer    | null: false                     |
| user_id             | references | null: false, foreign_key: true  |

### Association

- belongs_to :users
- has_one :orders


## orders テーブル

| Column  | Type       | Options                         |
| ------- | ---------- | ------------------------------- |
| user_id | references | null: false, foreign_key: true  |
| item_id | references | null: false, foreign_key: true  |

### Association

- belongs_to :users
- belongs_to :items
- has_one :deliveries

## Deliveries テーブル

| Column       | Type       | Options                         |
| ------------ | ---------- | ------------------------------- |
| postal-code  | string     | null: false                     |
| prefecture   | string     | null: false                     |
| city         | string     | null: false                     |
| addresses    | string     | null: false                     |
| building     | string     |                                 |
| phone-number | string     | null: false                     |
| order_id     | references | null: false, foreign_key: true  |

### Association

- belongs_to :orders