class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :address, :house_number, :building, :tel

  with_option presence: true do
    validates :user_id, :item_id, :address, :house_number
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ } 
    validates :tel, format: { with: /\A\d{10}|\d{11}\z/ }
    validates :prefecture_id, numericality: {other_than: 1}
end