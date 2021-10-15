class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :product_number
      t.date :manufature_date
      t.integer :price
      t.integer :quantity
      t.string :variant
      t.text :description

      t.timestamps
    end
  end
end
