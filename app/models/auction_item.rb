class AuctionItem < ApplicationRecord
  has_many :item_product
  belongs_to :product_model
  belongs_to :auction_lot
  validates :quantity, presence: true
end
