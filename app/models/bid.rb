class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot

  validate :greater_than_minimum_bid
  validate :greater_than_current_bid
  validate :before_auction_end

  def greater_than_minimum_bid
    if amount < auction_lot.value_min
      errors.add(:amount, "deve ser maior que o lance mínimo.")
    end
  end

  def greater_than_current_bid
    if auction_lot.bids.any?
      max_bid = auction_lot.bids.maximum(:amount) || 0
      if amount <= max_bid + auction_lot.diff_min
        errors.add(:amount, "deve ser maior que o lance atual somado com a diferença mínima.")
      end
    end
  end

  def before_auction_end
    if Time.current > auction_lot.limit_date
      errors.add(:base, "O lance não pode ser feito após o encerramento do leilão.")
    end
  end
end

