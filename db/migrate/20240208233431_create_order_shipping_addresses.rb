class CreateOrderShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_shipping_addresses do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :addresses, null: false
      t.string :building
      t.string :phone_number, null: false
      t.references :order, foreign_key: true, null: false

      t.timestamps
    end
  end
end
