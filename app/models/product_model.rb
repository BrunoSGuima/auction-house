class ProductModel < ApplicationRecord
  belongs_to :category
  has_many :products
  has_many :auction_lots, through: :products
  validates :code, :name, :description, :weight, :width, :height, :depth, presence: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create
  has_one_attached :image


  def products_available_count
    products.where(auction_lot_id: nil).count
  end

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
