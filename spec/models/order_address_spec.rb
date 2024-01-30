require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
    @bad_zip_code = ["１２３-４５６７","１２３４５６７",Faker::Number.number(digits: 7),]
    @bad_telephone = ["１２３４５６７８９１", "090-1234-5678"]
  end

  describe '商品の購入' do
    context '購入できる場合' do
      it 'zip_code,state_province_id,city_town_village,street_address,telephone,user_id,item_id, :tokenが存在すれば登録できる' do
        expect(@order_address).to be_valid
      end
    end
    context '購入できない場合' do
      it '郵便番号がなければ保存できない。' do
        @order_address.zip_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列出なければ保存できない。' do
        @bad_zip_code.each do|zip_code|
          @order_address.zip_code = zip_code
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Zip code is invalid")
        end
      end
      it '都道府県がなければ保存できない。' do
        @order_address.state_province_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("State province can't be blank")
      end
      it '市区町村がなければ保存できない。' do
        @order_address.city_town_village = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City town village can't be blank")
      end
      it '番地がなければ保存できない。' do
        @order_address.street_address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号がなければ保存できない。' do
        @order_address.telephone = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Telephone can't be blank")
      end
      context '電話番号は、10桁以上11桁以内の半角数値でなければ保存できない' do
        it '電話番号は、半角数値のみでなければ保存できない' do
          @bad_telephone.each do|telephone|
            @order_address.telephone = telephone
            @order_address.valid?
            expect(@order_address.errors.full_messages).to include("Telephone is not a number")
          end
        end
        it '電話番号は、10桁以上でなければ保存できない' do
          @order_address.telephone = Faker::Number.leading_zero_number(digits: 9)
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Telephone is too short (minimum is 10 characters)")
        end
        it '電話番号は、11桁以下でなければ保存できない' do
          @order_address.telephone = Faker::Number.leading_zero_number(digits: 12)
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Telephone is too long (maximum is 11 characters)")
        end
        it 'tokenは空では保存できない' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end