class AuctionLot < ApplicationRecord
  validates :code, :start_date, :limit_date, :value_min, :diff_min, presence: true
  validates :code, uniqueness: true
  belongs_to :user
  has_many :products, dependent: :nullify
  has_many :product_models, through: :products, dependent: :nullify
  has_many :bids
  has_one :auction_approval
  has_many :favorite_auction_lots, dependent: :destroy
  has_many :questions
  

  enum status: {pending: 0, approved: 5, expired: 9, closed: 10, canceled: 15}
  
  validate :start_date_is_future, on: :create
  validate :limit_date_after_start
  validate :code_format

  def minimum_bid
    if bids.any?
      bids.maximum(:amount).to_i + diff_min
    else
      value_min
    end
  end

  def self.expire_lots
    where("limit_date < ?", Date.today).where.not(status: [statuses[:expired], statuses[:canceled], statuses[:closed]]).update_all(status: statuses[:expired])
  end
  
  def approve_by(user)
    update(status: 'approved')
    auction_approval = AuctionApproval.new(auction_lot: self, approved_by: user)
    auction_approval.save
  end

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

