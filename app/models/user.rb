class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birthday_on, presence: true
  validates :password, format: { with:/\A(?=.*[0-9])(?=.*[a-z])[a-z0-9]+\z/i }, presence: true
  validates :last_name, :first_name, format: {without: /[a-z\d]/i },  presence: true
  validates :first_name_kana, :last_name_kana, format: {with: /\A[ア-ヵー]+\z/}, presence: true

  has_many :items
  has_many :purchases

end
