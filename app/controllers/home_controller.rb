class HomeController < ApplicationController
  def index
    AuctionLot.expire_lots
    if user_signed_in? && current_user.admin?
      @ongoing_auction_lots = AuctionLot.where("start_date <= ?", Time.zone.now).order(created_at: :desc)
      @future_auction_lots = AuctionLot.where("start_date > ?", Time.zone.now).order(created_at: :desc)
    else
      @ongoing_auction_lots = AuctionLot.where(status: 'approved').where("start_date <= ?", Time.zone.now).order(created_at: :desc)
      @future_auction_lots = AuctionLot.where(status: 'approved').where("start_date > ?", Time.zone.now).order(created_at: :desc)
    end
  end
end