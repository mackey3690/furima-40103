class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping
  accepts_nested_attributes_for :shipping
end
