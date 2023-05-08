class AuctionApproval < ApplicationRecord
  belongs_to :auction_lot
  belongs_to :approved_by, class_name: 'User', foreign_key: 'approved_by_id'
  
  validates :auction_lot_id, uniqueness: true
  
end
