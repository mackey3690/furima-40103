class ShippingPurchase
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :addresses
    validates :phone_number, length: { minimum: 10, message: 'is too short (minimum is 10 characters)' }
    validates :phone_number, length: { maximum: 11, message: 'is too long (maximum is 11 characters)' }
    validates :token
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(item_id:, user_id:)
    Shipping.create(postal_code:, prefecture:, city:, addresses:, building:,
                    phone_number:, purchase_id: purchase.id)
  end
end
