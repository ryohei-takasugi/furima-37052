require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @order_delivery = FactoryBot.build(:order_delivery)
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_delivery.item_id = @item.id
    @order_delivery.user_id = @user.id
    # FIXME: なぜかSleepしないと「MySQL client is not connected」が発生する
    sleep 0.1
  end
  describe '商品購入' do
    context '商品を購入できる場合' do
      it 'token, price, postal_code, prefecture_id, city, addresses, phone_number, item_id, user_id が存在すれば登録できる' do
        expect(@order_delivery).to be_valid
      end
      it 'buildingが存在しなくても登録できる' do
        @order_delivery.building = nil
        expect(@order_delivery).to be_valid
      end
    end
    context '商品を購入できない場合' do
      # 空では登録できない
      it 'token が空では登録できない' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_code が空では登録できない' do
        @order_delivery.postal_code = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefecture_id が空では登録できない' do
        @order_delivery.prefecture_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'city が空では登録できない' do
        @order_delivery.city = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it 'addresses が空では登録できない' do
        @order_delivery.addresses = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_number が空では登録できない' do
        @order_delivery.phone_number = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'item_id が空では登録できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'user_id が空では登録できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      # フォーマットエラー
      it 'prefecture_id が0では登録できない' do
        @order_delivery.prefecture_id = 0
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'postal_code が ハイフンなし でなければ登録できない' do
        @order_delivery.postal_code = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_code が ハイフンの左側が3桁未満 でなければ登録できない' do
        @order_delivery.postal_code = '12-4567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_code が ハイフンの左側が3桁より大きい でなければ登録できない' do
        @order_delivery.postal_code = '1234-5678'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_code が ハイフンの右側が4桁未満 でなければ登録できない' do
        @order_delivery.postal_code = '123-456'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_code が ハイフンの右側が4桁より大きい でなければ登録できない' do
        @order_delivery.postal_code = '123-45678'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'phone_number が全角では登録できない' do
        @order_delivery.phone_number = '０９０１２３４５６７８'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_number が半角英字では登録できない' do
        @order_delivery.phone_number = 'abcdeabcdef'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_number が半角英数字では登録できない' do
        @order_delivery.phone_number = '09o12345678'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'phone_number が9桁では登録できない' do
        @order_delivery.phone_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is too short')
      end
      it 'phone_number が12桁では登録できない' do
        @order_delivery.phone_number = '123456789012'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is too short')
      end
    end
  end
end
