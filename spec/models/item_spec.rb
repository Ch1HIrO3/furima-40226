require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @full_pitch_array = ["ひらがな","漢字","alphabet","１２３４５"]
  end

  describe '商品の出品' do
    context '出品できる場合' do
      it 'name・description・category_id・condition_id・shipping_charge_idstate_province_id・days_to_ship_id・price・user・image が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it '商品画像が空では登録できない。' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない。' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空では登録できない。' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が空では登録できない。' do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it '商品の状態の情報が空では登録できない。' do
        @item.condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition is not a number")
      end
      it '配送料の負担の情報が空では登録できない。' do
        @item.shipping_charge_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge is not a number")
      end
      it '発送元の地域の情報が空では登録できない。' do
        @item.state_province_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("State province is not a number")
      end
      it '発送までの日数の情報が空では登録できない。' do
        @item.days_to_ship_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship is not a number")
      end
      it '価格の情報が空では登録できない。' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      context '価格は、¥300~¥9,999,999の間でなければ登録できない。' do
        it '価格は、¥300以下では登録できない' do
          @item.price = Faker::Number.between(from: 0, to: 299)
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
        end
        it '価格は、¥9,999,999以上では登録できない' do
          @item.price = Faker::Number.between(from: 9999999, to: 99999999)
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
        end
      end
        it '価格は半角数値でなければ保存できない。' do
          @full_pitch_array.each do|price|
            @item.price = price
            @item.valid?
            expect(@item.errors.full_messages).to include "Price is not a number"
          end
        end
    end
  end
end