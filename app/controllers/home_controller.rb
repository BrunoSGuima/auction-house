class HomeController < ApplicationController
  def index
    @auction_lots = AuctionLot.all
  end
end