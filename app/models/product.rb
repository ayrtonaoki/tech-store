class Product < ApplicationRecord
  validates :name, length: { minimum: 3 }
  validates :description, length: { minimum: 5 }
  validates :price, :amount, presence: true
end
