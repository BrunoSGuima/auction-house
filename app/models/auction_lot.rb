class AuctionLot < ApplicationRecord
  validates :code, :start_date, :limit_date, :value_min, :diff_min, presence: true
  validates :code, uniqueness: true
  belongs_to :user
  has_many :product_models, through: :products
  has_many :products
  has_one :auction_approval, dependent: :destroy
  enum status: {pending: 0, approved: 5, canceled: 9}
  
  validate :start_date_is_future
  validate :limit_date_after_start
  validate :code_format




  private
  def start_date_is_future
    if start_date.present? && start_date < Date.today
       errors.add(:start_date, " deve ser futura.")
    elsif start_date == Date.today
    end
  end

  
  def limit_date_after_start
    if start_date.present? && limit_date.present?  && limit_date < start_date
      errors.add(:limit_date, " deve ser após o dia inicial.")
    end
  end

  def code_format
    unless code.length == 6 && code.count("A-Za-z") == 3
      errors.add(:code, "o código deve ser composto por 3 letras e 6 caracteres")
    end
  end
end

