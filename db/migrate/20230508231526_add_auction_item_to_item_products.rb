class AddAuctionItemToItemProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :item_products, :auction_item, null: false, foreign_key: true
  end
end
