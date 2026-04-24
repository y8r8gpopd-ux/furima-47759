class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :address, :house_number, :building, :tel, :token

  with_options presence: true do
    validates :user_id, :item_id, :address, :house_number
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ } 
    validates :tel, format: { with: /\A\d{10,11}\z/ }
    validates :prefecture_id, numericality: {other_than: 1}
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code,
                           prefecture_id: prefecture_id,
                           address: address,
                           house_number: house_number,
                           building: building, 
                           tel: tel, 
                           purchase_id: purchase.id)
  end

end