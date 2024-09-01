require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do  
    context '新規登録ができる場合' do
      it "全ての項目に入力できている" do
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上の半角英数字混合であれば登録できる' do  
        @user.password = "000aaa"
        @user.password_confirmation = "000aaa"
        expect(@user).to be_valid
      end
      #全角文字のテスト
      it 'last_nameが全角(漢字・ひらがな・カタカナ)文字であれば登録できる' do
        @user.last_name = "松井"
        expect(@user).to be_valid
      end  
      it 'last_name_kanaが全角（カタカナ）文字であれば登録できる' do
        @user.last_name_kana = "マツイ"
        expect(@user).to be_valid
      end  
      it 'first_nameが全角(漢字・ひらがな・カタカナ)文字であれば登録できる' do
        @user.first_name = "ああ"
        expect(@user).to be_valid
      end  
      it 'first_name_kanaが全角（カタカナ）文字であれば登録できる' do
        @user.first_name_kana = "アア"
        expect(@user).to be_valid
      end  
    end   
    
    context '新規登録ができない場合' do
      #null: false のテスト
      it 'nickname:必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
    
      it 'email:必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'passwaord:必須' do
        @user.password = ''
        @user.valid?
        
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      #passwordの条件テスト
      it 'passwordが5文字以下だと登録できない' do
        @user.password = "00aaa"
        @user.password_confirmation = '00aaa'
        

        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      
      it 'passwordは数字のみだと登録できない' do
        @user.password = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it 'passwordは英字のみだと登録できない' do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '000aaa'
        @user.password_confirmation = '111bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'passwordは全角文字が含まれると登録できない' do
        @user.password = "aaああaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
        #email の条件テスト（一意性）

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end  
      # (@ の有無）
      it '@を含まないemailだと登録できない' do
        @user.email = 'aaaaaaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      #本人情報確認 [お名前]名字
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      
      it 'last_nameは全角(漢字・ひらがな・カタカナ)文字が必須' do
        @user.last_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end  

      it 'last_name_kanaは全角(カタカナ)文字が必須' do
        @user.last_name_kana = 'ああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナ文字を使用してください")
      end
      
      #本人情報確認　[お名前]名前
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it 'first_nameは全角(漢字・ひらがな・カタカナ)文字が必須' do
        @user.first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end  

      it 'first_name_kanaは全角(カタカナ)文字が必須' do
        @user.first_name_kana = 'ああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナ文字を使用してください")
      end 
      #本人情報確認　[生年月日]
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end      
    end
  end
end