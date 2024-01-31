# README
# テーブル設計

## Usersテーブル
| Column                | Type   | Options                              |
| --------------------- | ------ | ------------------------------------ |
| nickname              | string | limit: 40, null: false, unique: true |
| email                 | string | null: false, unique: true            |
| password              | string | null: false, length: { minimum: 6 }  |
| last-name             | string | null: false                          |
| first-name            | string | null: false                          |
| last-name-kana        | string | null: false                          |
| first-name-kana       | string | null: false                          |
| birth-date            | date   | null: false                          |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## Itemsテーブル
| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| item-name                  | string     | null: false                    |
| item-info                  | text       | null: false                    |
| item-category              | integer    | null: false                    |
| item-sales-status          | integer    | null: false                    |
| item-shipping-fee-status   | integer    | null: false                    |
| item-prefecture            | integer    | null: false                    |
| item-scheduled-delivery    | integer    | null: false                    |
| item-price                 | integer    | null: false                    |
| user_id                    | references | null: false, foreign_key: true |

### Association
- has_many :comments
- belongs_to :user
- has_one :order

## Ordersテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :ShippingAddresses

## ShippingAddressesテーブル
| Column       | Type       | Options     |
| ------------ | ---------- | ----------- |
| postal-code  | string     | null: false |
| prefecture   | string     | null: false |
| city         | string     | null: false |
| addresses    | string     | null: false |
| building     | string     | null: false |
| phone-number | string     | null: false |
| order_id     | references | null: false |

### Association
- belongs_to :order

## Commentsテーブル
| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| user_id | references | null: false |
| item_id | references | null: false |
| comment | string     | null: false |

### Association
- belongs_to :user
- belongs_to :item