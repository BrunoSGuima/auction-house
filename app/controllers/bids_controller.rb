class BidsController < ApplicationController
  
  def create
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    if @auction_lot.start_date.to_date <= Date.today && Date.today <= @auction_lot.limit_date.to_date && @auction_lot.status == 'approved'
      @bid = Bid.new(bid_params)
      @bid.auction_lot = @auction_lot
      @bid.user = current_user
      if @bid.save
        redirect_to @auction_lot, notice: 'Seu lance foi feito com sucesso.'
      else
        redirect_to auction_lot_path(@auction_lot), alert: 'Não foi possível fazer o seu lance! ' + @bid.errors.full_messages.to_sentence
      end
    else
    redirect_to @auction_lot, alert: 'Os lances não estão disponíveis.'
    end
  end

  def index
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @bids = @auction_lot.bids.order(created_at: :desc)
  end
  

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
