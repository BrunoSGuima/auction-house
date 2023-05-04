class ProductModel < ApplicationRecord
  validates :code, :name, :description, :weight, :width, :height, :depth, presence: true
  validates :code, uniqueness: true

  before_validation :generate_code, on: :create

  def dimension
    "#{width} - #{height} - #{depth}"
  end



  private
  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
