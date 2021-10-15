class Product < ApplicationRecord
  validates :product_name, :product_number, :quantity, :price, :variant, :manufature_date, presence: true
end
