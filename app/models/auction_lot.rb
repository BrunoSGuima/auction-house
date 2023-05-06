class AuctionLot < ApplicationRecord
  enum status: {pending: 0, approved: 5, canceled: 9}
end
