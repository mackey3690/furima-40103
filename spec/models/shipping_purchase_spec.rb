require 'rails_helper'

RSpec.describe ShippingPurchase, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @shipping_purchase = FactoryBot.build(:shipping_purchase, user_id: user.id, item_id: item.id)
    sleep(1)
  end
  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@shipping_purchase).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @shipping_purchase.building = ''
        expect(@shipping_purchase).to be_valid
      end
      it 'tokenがあれば保存ができること' do
        expect(@shipping_purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @shipping_purchase.postal_code = ''
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @shipping_purchase.postal_code = '1234567'
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @shipping_purchase.prefecture = 0
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @shipping_purchase.city = ''
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空だと保存できないこと' do
        @shipping_purchase.addresses = ''
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @shipping_purchase.phone_number = ''
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      
      it 'phone_numberが9桁以下では登録できないこと。また、12桁以上でも登録できないこと' do
        @shipping_purchase.phone_number = '123456789012' 
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include('Phone number is too long (10 characters or 11 characters)')
      end
      it 'userが紐付いていないと保存できないこと' do
        @shipping_purchase.user_id = nil
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @shipping_purchase.item_id = nil
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @shipping_purchase.token = nil
        @shipping_purchase.valid?
        expect(@shipping_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
