class CreateItemProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :item_products do |t|
      t.references :auction_lot, null: false, foreign_key: true
      t.references :product_model, null: false, foreign_key: true
      t.string :serial_number

      t.timestamps
    end
  end
end
