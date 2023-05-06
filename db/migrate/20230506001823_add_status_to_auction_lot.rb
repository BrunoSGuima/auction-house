class AddStatusToAuctionLot < ActiveRecord::Migration[7.0]
  def change
    add_column :auction_lots, :status, :integer, default: 0
  end
end
