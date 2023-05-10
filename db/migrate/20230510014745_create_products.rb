class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :product_model, null: false, foreign_key: true
      t.references :auction_lot, null: true, foreign_key: true
      t.string :serial_number

      t.timestamps
    end
  end
end
