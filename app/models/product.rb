class Product < ApplicationRecord
  belongs_to :product_model
  belongs_to :auction_lot, optional: true
  before_validation :generate_serial_number, on: :create
  validates :serial_number, presence: true, uniqueness: true, if: :auction_lot_id?
  validate :unique_in_auction_lot








  private

  def unique_in_auction_lot
    return unless auction_lot_id
  
    duplicate_item = Product.where(serial_number: serial_number).where.not(auction_lot_id: auction_lot_id).first
    errors.add("o item está indisponível") if duplicate_item
  end

  def generate_serial_number
    self.serial_number = SecureRandom.alphanumeric(10).upcase
  end

end