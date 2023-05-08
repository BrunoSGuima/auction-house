class AuctionLotsController < ApplicationController
  before_action :set_auction, only: [:edit, :update, :show, :destroy, :approve]

  def new
    @auction_lot = AuctionLot.new
  end

  def approve
    if current_user.admin? && current_user != @auction_lot.user
      @auction_lot.update(status: 'approved')
      @auction_approval = AuctionApproval.new(auction_lot: @auction_lot, approved_by: current_user)
      if @auction_approval.save
        redirect_to @auction_lot, notice: 'Lote aprovado com sucesso!'
      else
        redirect_to @auction_lot, alert: 'Não foi possível aprovar o lote.'
      end
    else
      redirect_to @auction_lot, alert: 'Você não tem permissão para aprovar este lote.'
    end
  end

  def show
  end
  
  def edit; end

  def update
    auction_param
      if @auction_lot.update(auction_param)
        redirect_to @auction_lot, notice: "Lote atualizado com sucesso!"
      else
        flash[:notice] = "Não foi possível atualizar o lote."
        render 'edit'
      end
  end

  def create
    @auction_lot = AuctionLot.new(auction_param)
    @auction_lot.user = current_user
    if @auction_lot.save
      redirect_to root_path, notice: "Lote cadastrado com sucesso!"
    else
      flash.now[:notice] = "Lote não cadastrado."
      render 'new'
    end
  end

  def destroy
    @auction_lot.destroy
    if @auction_lot.destroy
      redirect_to root_path, notice: "Lote removido com sucesso!"
    else
      flash[:notice] = 'Não foi possível remover o Lote'
      render 'show'
    end
  end
 
  private
  def set_auction
    @auction_lot = AuctionLot.find(params[:id])
  end

  def auction_param
    params.require(:auction_lot).permit(:code, :start_date, :limit_date, :value_min, :diff_min, :status)
  end 
  
end