# テーブル設計
# 4月23日 現在データベースが停止しております。復旧作業中です。

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null: false                   |
| description        | text       | null: false                   |
| category_id        | integer    | null: false                   |
| condition_id       | integer    | null: false                   |
| shipping_charge_id | integer    | null: false                   |
| state_province_id  | integer    | null: false                   |
| days_to_ship_id    | integer    | null: false                   |
| price              | integer    | null: false                   |
| user               | references | null: false ,foreign_key: true|

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| user              | references | null: false, foreign_key: true |
| item              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| zip_code          | string     | null: false                    |
| state_province_id | integer    | null: false                    |
| city_town_village | string     | null: false                    |
| street_address    | string     | null: false                    |
| building_name     | string     |                                |
| telephone         | string     | null: false                    |
| order             | references | null: false, foreign_key: true |

### Association
- belongs_to :order

