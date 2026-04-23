class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_fee
  belongs_to :shipping_time
  has_one :purchase

  validates :name, :description, :image, presence: true
  validates :price, presence: true, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 300,
                                                    less_than_or_equal_to: 9999999 }

  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_time_id, presence: true, numericality:{
                                                                                                              other_than: 1 } 

end
