class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  # has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  belongs_to_active_hash :shipping_fee_status
  belongs_to :item_shipping_fee_status, class_name: "ShippingFeeStatus"

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :item_price, presence: true,
                    numericality: { only_integer: true, message: 'is invalid. Input integer value in half-width characters' }
  validates :item_price, numericality: { in: 300..9_999_999, message: 'is out of setting range' }
  validates :item_category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_sales_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank" }
end
