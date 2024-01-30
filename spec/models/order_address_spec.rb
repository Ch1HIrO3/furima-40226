require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    @bad_zip_code = ["１２３-４５６７","１２３４５６７",Faker::Number.number(digits: 7),]
    @bad_telephone = ["１２３４５６７８９１", "090-1234-5678"]
  end

  describe '商品の購入' do
    context '購入できる場合' do
      it 'zip_code,state_province_id,city_town_village,street_address,telephone,user_id,item_id, :tokenが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物名の入力がなくても購入できる' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end
    end
    context '購入できない場合' do
      it '郵便番号がなければ購入できない。' do
        @order_address.zip_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列出なければ購入できない。' do
        @bad_zip_code.each do|zip_code|
          @order_address.zip_code = zip_code
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Zip code is invalid")
        end
      end
      it '都道府県がなければ購入できない。' do
        @order_address.state_province_id = "1"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("State province must be other than 1")
      end
      it '市区町村がなければ購入できない。' do
        @order_address.city_town_village = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City town village can't be blank")
      end
      it '番地がなければ購入できない。' do
        @order_address.street_address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号がなければ購入できない。' do
        @order_address.telephone = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Telephone can't be blank")
      end
      context '電話番号は、10桁以上11桁以内の半角数値でなければ購入できない' do
        it '電話番号は、半角数値のみでなければ購入できない' do
          @bad_telephone.each do|telephone|
            @order_address.telephone = telephone
            @order_address.valid?
            expect(@order_address.errors.full_messages).to include("Telephone is not a number")
          end
        end
        it '電話番号は、10桁以上でなければ購入できない' do
          @order_address.telephone = Faker::Number.leading_zero_number(digits: 9)
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Telephone is too short (minimum is 10 characters)")
        end
        it '電話番号は、11桁以下でなければ購入できない' do
          @order_address.telephone = Faker::Number.leading_zero_number(digits: 12)
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Telephone is too long (maximum is 11 characters)")
        end
      end
      it 'user_idは空では購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idは空では購入できない' do
          @order_address.item_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenは空では購入できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end