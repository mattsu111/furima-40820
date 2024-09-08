require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)

  end
  
  
  describe '商品出品' do  
    context '商品を出品できる場合' do
      it "全ての項目に入力できている" do
        expect(@item).to be_valid
      end  
    end  
    context '商品が出品できないとき' do
      
      it '画像が空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end  
      it '商品名が空では出品できない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end  
      
      it '説明が空だと出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      #ActiveHash５項目
      it 'カテゴリーが空だと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end  
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end  
      it '状態が空だと出品できない' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end 
      
      it '状態に「---」が選択されている場合は出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end  
    
      it '配送料負担が空だと出品できない' do
        @item.delivery_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.delivery_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee can't be blank")
      end  
      it '発送元が空だと出品できない' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送日までの日数が空だと出品できない' do
        @item.ship_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship date can't be blank")
      end  
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.ship_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship date can't be blank")
      end  
      #priceのテスト
      it '価格が空だと出品できない' do
        @item.price = ''
        @item.valid? 
        expect(@item.errors.full_messages).to include("Price is not a number", "Price Price is invalid.harf-width characters")

      end  
      
      it '価格は全角文字が含まれると出品できない' do
        @item.price = '５００'
        @item.valid? 
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は300円以上でないと出品できない' do
        @item.price = '299'
        @item.valid?
        
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
    
      end

      it '価格は9,999,999円以下でないと出品できない' do
        @item.price = '10_000_000'
        @item.valid?
        
        expect(@item.errors.full_messages).to include("Price must be an integer")
      end 
      #出品者情報
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        
        expect(@item.errors.full_messages).to include("User must exist")
      
      end  

    end
  end
end  