class AuctionLot < ApplicationRecord
  validates :code, :start_date, :limit_date, :value_min, :diff_min, presence: true
  validates :code, uniqueness: true
  enum status: {pending: 0, approved: 5, canceled: 9}
end
