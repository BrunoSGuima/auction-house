class FavoriteAuctionLot < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot
  validates :user_id, uniqueness: { scope: :auction_lot_id }

  
end