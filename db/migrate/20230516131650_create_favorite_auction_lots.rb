class CreateFavoriteAuctionLots < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_auction_lots do |t|
      t.references :user, null: false, foreign_key: true
      t.references :auction_lot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
