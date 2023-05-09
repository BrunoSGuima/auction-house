class CreateAuctionItems < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_items do |t|
      t.references :product_model, null: false, foreign_key: true
      t.references :auction_lot, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
