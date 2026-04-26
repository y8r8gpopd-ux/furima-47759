require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: user.id, item_id: item.id)
  end

  describe "商品の購入機能" do

    context "商品の購入ができるとき" do
      it "入力されたデータが全て正しければ商品の購入ができる" do
        expect(@purchase_shipping_address).to be_valid
      end

      it "建物名(building)は空でも購入できる" do
        @purchase_shipping_address.building = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end

    context "商品の購入ができないとき" do
      it "郵便番号(post_code)が空では購入できない" do
        @purchase_shipping_address.post_code = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end

      it "郵便番号(post_code)は半角数字「3桁-4桁」の形でハイフンを入れなければ購入できない" do
        @purchase_shipping_address.post_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid")
        @purchase_shipping_address.post_code = '１２３-４５６７'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid")
      end

      it "都道府県(prefecture_id)は１(---)以外でなければ購入できない" do
        @purchase_shipping_address.prefecture_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it "市区町村(address)が空では購入できない" do
        @purchase_shipping_address.address = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Address can't be blank")
      end

      it "番地(house_number)が空では購入できない" do
        @purchase_shipping_address.house_number = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("House number can't be blank")
      end

      it "電話番号(tel)が空では購入できない" do
        @purchase_shipping_address.tel = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Tel can't be blank")
      end

      it "電話番号はハイフンなしで10~11桁の半角数字でなければ購入できない" do
        @purchase_shipping_address.tel = '090-1234-5678'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Tel is invalid")
        @purchase_shipping_address.tel = '０９０１２３４５６７８'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Tel is invalid")
      end

      it "カード情報の入力が正しくなく、カード決済のトークン(token)が空では購入できない" do
        @purchase_shipping_address.token = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it "ユーザー(user)が紐づいていないと購入できない" do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it "商品(item)が紐づいていないと購入できない" do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end

  end

end
