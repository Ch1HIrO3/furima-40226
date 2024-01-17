# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| description        | text       | null: false                   |
| category_id        | string     | null: false                   |
| condition_id       | string     | null: false                   |
| shipping_charge_id | string     | null: false                   |
| state_province_id  | string     | null: false                   |
| days_to_ship_id    | string     | null: false                   |
| price              | integer    | null: false                   |
| user               | references | null: false ,foreign_key: true|

### Association

- belongs_to :users
- has_one :orders

## orders テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| credit_number     | integer    | null: false                    |
| expiration_date   | date       | null: false                    |
| security_code     | integer    | null: false                    |
| zip_code          | integer    | null: false                    |
| state_province_id | string     | null: false                    |
| city_town_village | string     | null: false                    |
| street_address    | string     | null: false                    |
| building_name     | string     |                                |
| telephone         | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items

