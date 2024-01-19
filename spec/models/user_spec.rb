require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @name_array = ["ひらがな","漢字","alphabet","123"]
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録できる場合' do
      it "nickname・email・password・last_name・first_name・last_name_kana・first_name_kana・birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'ニックネームが空では登録できない。' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it 'パスワードが空では登録できない。' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードは、6文字以下では登録できない。' do
        @user.password = Faker::Internet.password(min_length:2, max_length:5)
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it 'パスワードは、半角英数字混合でなければ登録できない。' do
        @password_array=["いろはにほへと","alphabet","ｂｇｆｄｊｓｊ","123456","１２３４５６",]
        @password_array.each do|password|
          @user.password = password
          @user.valid?
          expect(@user.errors.full_messages).to include "Password is invalid"
        end
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = Faker::Internet.password(min_length:6)
        @user.password_confirmation =! @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
    end
  end
  describe '新規登録/本人情報確認' do
    context '新規登録できない場合' do
      context 'お名前(全角)は、名字と名前がどちらも入力されないと登録できない' do
        it 'お名前(全角)は、名字が空欄では登録できない' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Last name can't be blank"
        end
        it 'お名前(全角)は、名前が空欄では登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "First name can't be blank"
        end
      end
      context 'お名前(全角)は、半角では登録できない' do
        it 'お名前(全角)は、名字が半角では登録できない' do
          @user.last_name = Faker::Name.last_name
          @user.valid?
          expect(@user.errors.full_messages).to include "Last name is invalid"
        end
        it 'お名前(全角)は、名前が半角では登録できない' do
          @user.first_name = Faker::Name.first_name
          @user.valid?
          expect(@user.errors.full_messages).to include "First name is invalid"
        end
      end
      context 'お名前カナ(全角)は、名字と名前がどちらも入力されないと登録できない' do
        it 'お名前カナ(全角)は、名字が空欄では登録できない' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Last name kana can't be blank"
        end
        it 'お名前カナ(全角)は、名前が空欄では登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "First name kana can't be blank"
        end
      end
      context 'お名前カナ(全角)は、全角（カタカナ）以外では登録できない' do
        it 'お名前カナ(全角)は、ひらがな・漢字・アルファベット・数字では登録できない' do
          @name_array.each do|name|
            @user.first_name_kana = name
            @user.valid?
            expect(@user.errors.full_messages).to include "First name kana is invalid"
          end
        end
        it 'お名前カナ(全角)はひらがな・漢字・アルファベット・数字では登録できない' do
          @name_array.each do|name|
            @user.last_name_kana = name
            @user.valid?
            expect(@user.errors.full_messages).to include "Last name kana is invalid"
          end
        end
      end
      it '生年月日が空欄では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
  describe 'トップページ' do
    context '新規登録できない場合' do
    end
  end
end