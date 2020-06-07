class Product < ApplicationRecord
  belongs_to :category

  validates :name, length: { minimum: 3 }
  validates :description, length: { minimum: 5 }
  validates :price, :amount, :category, presence: true
end
