require 'rails_helper'
require 'faker'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.user_id = user.id
  end

  describe '商品出品' do
    context '出品できる場合' do
      it '全ての項目が適切に入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '商品画像が無いと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が無いと出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が無いと出品できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      it 'カテゴリーが未選択だと出品できない' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end
      it '商品の状態が未選択だと出品できない' do
        @item.item_sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item sales status can't be blank")
      end
      it '配送料の負担が未選択だと出品できない' do
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item shipping fee status can't be blank")
      end
      it '発送元の地域が未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が未選択だと出品できない' do
        @item.item_scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item scheduled delivery can't be blank")
      end
      it '価格が無いと出品できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank")
      end
      it '価格が半角数字以外だと出品できない' do
        @item.item_price = Faker::Lorem.sentence
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is invalid. Input integer value in half-width characters')
      end
      it '価格が小数値だと出品できない' do
        @item.item_price = Faker::Number.decimal(l_digits: 4, r_digits: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is invalid. Input integer value in half-width characters')
      end
      it '価格が¥299以下だと出品できない' do
        @item.item_price = Faker::Number.between(to: 299)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is out of setting range')
      end
      it '価格が¥10,000,000以上だと出品できない' do
        @item.item_price = Faker::Number.between(from: 10_000_000, to: 20_000_000)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price is out of setting range')
      end
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
