require 'rails_helper'
describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品' do
    context '出品がうまくいくとき' do
      it 'すべての値が正しく入力すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it '商品の画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品の説明が空だと登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品名が空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'カテゴリーの情報が1だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category id Select')
      end
      it '商品の状態が1だと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition id Select')
      end
      it '配送料の負担が1だと登録できない' do
        @item.postage_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage payer id Select')
      end
      it '発送元の地域が1だと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture id Select')
      end
      it '発送までの日数が1だと登録できない' do
        @item.handling_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Handling time id Select')
      end
      it '価格が空だと登録できない' do
        @item.price = []
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が全角登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price half-width number')
      end
      it '価格の範囲が３００未満だと登録できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price half-width number')
      end
      it '価格の範囲が９９９９９９９以上だと登録できない' do
        @item.price = 9_999_999_999
        @item.valid?
        expect(@item.errors.full_messages).to include('Price half-width number')
      end
    end
  end
end
