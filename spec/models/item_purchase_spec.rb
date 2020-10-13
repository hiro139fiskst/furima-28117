require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @item_purchase = FactoryBot.build(:item_purchase)
  end

  describe '購入情報の保存' do
    context '購入情報の保存がうまくいく時' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@item_purchase).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @item_purchase.building_name = nil
        expect(@item_purchase).to be_valid
      end
    end

    context '購入情報の保存がうまくいかない時' do
      it 'クレジットカードの情報がなければ保存できない' do
        @item_purchase.token = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号がなければ保存できない' do
        @item_purchase.post_code = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にはハイフンがなければ保存できない' do
        @item_purchase.post_code = 0o000000
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が選択されていなければ保存できない' do
        @item_purchase.prefecture_id = [2]
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村がなければ保存できない' do
        @item_purchase.city = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("City can't be blank")
      end
      it '番地がなければ保存できない' do
        @item_purchase.address_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Address number can't be blank")
      end
      it '電話番号がなければ保存できない' do
        @item_purchase.phone_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にはハイフンがあると保存できない' do
        @item_purchase.phone_number = '0000-00000'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Phone number は、ハイフン抜きで入力してください')
      end
    end
  end
end
