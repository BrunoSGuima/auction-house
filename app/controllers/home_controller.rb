class HomeController < ApplicationController
  def index
    AuctionLot.expire_lots
    @auction_lots = AuctionLot.where.not(status: AuctionLot.statuses[:expired])
  
    if user_signed_in? && current_user.admin?
      @auction_lots = AuctionLot.where.not(status: AuctionLot.statuses[:expired])
    else
      @auction_lots = AuctionLot.where(status: 'approved')
    end
  
    @ongoing_auction_lots = @auction_lots.where("start_date <= ? AND limit_date >= ?", Time.zone.now, Time.zone.now).order(created_at: :desc)
    @future_auction_lots = @auction_lots.where("start_date > ?", Time.zone.now).order(created_at: :desc)
  end 
end