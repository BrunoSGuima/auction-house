class HomeController < ApplicationController
  def index
    AuctionLot.expire_lots
    excluded_statuses = [AuctionLot.statuses[:expired], AuctionLot.statuses[:closed], AuctionLot.statuses[:canceled]]
    
    if user_signed_in? && current_user.admin?
      @auction_lots = AuctionLot.where.not(status: excluded_statuses)
    else
      @auction_lots = AuctionLot.where(status: 'approved')
    end
    
    @ongoing_auction_lots = @auction_lots.where("DATE(start_date) <= ? AND DATE(limit_date) >= ?", Date.current, Date.current).order(created_at: :desc)
    @future_auction_lots = @auction_lots.where("start_date > ?", Time.zone.now).order(created_at: :desc)
  end
  
end