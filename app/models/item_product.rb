class ItemProduct < ApplicationRecord
  belongs_to :auction_lot
  belongs_to :product_model
  belongs_to :auction_item
 
  
  before_validation :generate_serial_number, on: :create








  private

  def generate_serial_number
    self.serial_number = SecureRandom.alphanumeric(10).upcase
  end

end

