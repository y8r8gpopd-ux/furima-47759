require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do

    context "新規登録できるとき" do
      it "入力されたデータがすべて正しければ登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できないとき" do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@を含んでいないと登録できない" do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "すでに登録してあるemailは登録できない" do
        another_user = FactoryBot.create(:user)
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "パスワードが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードが6文字未満では登録できない" do
        @user.password = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードが129文字以上では登録できない" do
        @user.password = "a" * 129
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it "パスワードに英字、数字どちらも一つ以上含まれていないと登録できない" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
        @user.password = "123456"
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "パスワードの再入力不一致では登録できない" do
        @user.password_confirmation = "test12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "本人確認情報の苗字(last_name)が空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it "本人確認情報の苗字(last_name)に英数字は使用できない" do
        @user.last_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
        @user.last_name = "abc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it "本人確認情報の名前(first_name)が空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "本人確認情報の名前(first_name)に英数字は利用できない" do
        @user.first_name = "abc"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
        @user.first_name = "123"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it "本人確認情報の全角カナ苗字(last_name_kana)が空では登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it "本人確認情報の全角カナ苗字(last_name_kana)は全角カナのみでないと登録できない" do
        @user.last_name_kana = "テストone"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
        @user.last_name_kana = "テスト1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
        @user.last_name_kana = "テスト壱"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it "本人確認情報の全角カナ名前(first_name_kana)が空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "本人確認情報の全角カナ名前(first_name_kana)は全角カナのみでないと登録できない" do
        @user.first_name_kana = "テストone"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
        @user.first_name_kana = "テスト1"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
        @user.first_name_kana = "テスト壱"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it "本人確認情報の生年月日が空では登録できない" do
        @user.birthday_on = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday on can't be blank")
      end



    end



  end
end
