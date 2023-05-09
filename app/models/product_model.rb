class ProductModel < ApplicationRecord
  belongs_to :category
  has_many :auction_items
  has_many :auction_lots, through: :auction_items
  has_many :product_items
  validates :code, :name, :description, :weight, :width, :height, :depth, presence: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create
  attr_accessor :quantity






  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
