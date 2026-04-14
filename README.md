# データベース設計

# usersテーブル

 |column|type|options|
 |------|----|-------|
 |nickname|string|null:false|
 |email|string|null:false,unique:true|
 |encrypted_password|string|null:false|
 |last_name|string|null:false|
 |first_name|string|null:false|  
 |last_name_kana|string|null:false|  
 |first_name_kana|string|null:false|
 |birth_date|date|null:false|
 

 ## usersアソシエーション
  - has_many :items
  - has_many :purchases


# itemsテーブル

 |column|type|options|
 |------|----|-------|
 |name|string|null:false|
 |price|integer|null:false|
 |description|text|null:false|
 |user|references|null: false, foreign_key: true|
 ||ActiveHash||
 |category_id|integer|null: false|
 |condition_id|integer|null: false|
 |shipping_fee_id|integer|null: false|
 |prefecture_id|integer|null: false|
 |shipping_time_id|integer|null: false|

 ## itemsアソシエーション
  - belongs_to :user
  - has_one :purchase



# purchase中間テーブル

 |column|type|options|
 |------|----|-------|
 |user|references|null: false, foreign_key: true|
 |item|references|null: false, foreign_key: true|

 ## purchaseアソシエーション
  - belongs_to :user
  - belongs_to :item
  - has_one :shipping_address


# shipping_addressテーブル

 |column|type|options|
 |------|----|-------|
 |post_code|string|null: false|
 |address|string|null: false|
 |house_number|integer|null: false|
 |building|string||
 |tel|string|null: false|
 ||ActiveHash||
 |prefecture_id|reference|null: false|

 ## shipping_addressアソシエーション
 - belongs_to :purchase