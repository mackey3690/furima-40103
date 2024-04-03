class ShippingPurchase 
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :token


  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :addresses
    validates :phone_number, numericality: { only_integer: true, message: "Please enter half-width numbers"},
                                   length: { maximum: 11, message: "Please enter up to 11 letters"}
    validates :token, presence: true
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
  

  def save
     purchase = Purchase.create(item_id: item_id, user_id: user_id)
     Shipping.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end