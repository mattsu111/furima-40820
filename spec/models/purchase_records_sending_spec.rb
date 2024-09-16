require 'rails_helper'

RSpec.describe PurchaseRecordsSending, type: :model do
  describe '商品の購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @purchase_records_sending = FactoryBot.build(:purchase_records_sending, user_id: @user.id, item_id: [@item.id])
    end  

    context '商品を購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        
        expect(@purchase_records_sending).to be_valid
      end
      
      it 'buildingは空でも購入できること' do
        @purchase_records_sending.building = ''
        expect(@purchase_records_sending).to be_valid
      end  
    
    end


    context '商品を購入できない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_records_sending.postal_code = ''
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Postal code can't be blank")
      end
    
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @purchase_records_sending.postal_code = '1234567'
        @purchase_records_sending.valid?
        
        expect(@purchase_records_sending.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      
      it 'prefectureを選択していないと購入できない' do
        @purchase_records_sending.prefecture_id = 1
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it 'cityが空だと購入できない' do
        @purchase_records_sending.city = ''
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("City can't be blank")
      end
      
      it 'addressが空だと購入できない' do
        @purchase_records_sending.address = ''
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Address can't be blank")
      end  
    
      it 'telephone_numberが空だと購入できない' do
        @purchase_records_sending.telephone_number = ''
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberが10文字未満なら購入できない' do
        @purchase_records_sending.telephone_number = '123456789'
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Telephone number is invalid.")
      end
      it 'telephone_numberにハイフンが含まれると購入できない' do
        @purchase_records_sending.telephone_number = '123-456-789'    
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Telephone number is invalid.")
      end
      it 'telephone_numberは半角数字でないと購入できない' do
        @purchase_records_sending.telephone_number = '１２３４５６７８９０'
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Telephone number is invalid.")
      end
      it 'telephone_numberは12桁以上だと購入できない' do
        @purchase_records_sending.telephone_number = '123456789012'
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Telephone number is invalid.")
      end
        
      it 'userが紐づいていないと購入できない' do
        @purchase_records_sending.user_id = nil
        @purchase_records_sending.valid?
        
        expect(@purchase_records_sending.errors.full_messages).to include("User can't be blank")
      end
      
      it 'itemが紐づいていないと購入できない' do
        @purchase_records_sending.item_id = nil
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Item can't be blank")
      end              
      
      it "tokenが空では購入できない" do
        @purchase_records_sending.token = nil
        @purchase_records_sending.valid?
        expect(@purchase_records_sending.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
  
end 