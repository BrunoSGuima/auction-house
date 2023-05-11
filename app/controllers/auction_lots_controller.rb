class AuctionLotsController < ApplicationController
  before_action :check_status, only: [:remove_product, :add_product]
  before_action :set_auction, only: [:edit, :update, :show, :destroy, :approve, :remove_product, :add_product]
  before_action :expire_lots, only: [:show, :edit, :update]
 
  def new
    @auction_lot = AuctionLot.new
  end

  def approve
    if current_user.admin? && current_user != @auction_lot.user
      if @auction_lot.approve_by(current_user)
        redirect_to @auction_lot, notice: 'Lote aprovado com sucesso!'
      else
        redirect_to @auction_lot, alert: 'Não foi possível aprovar o lote.'
      end
    else
      redirect_to @auction_lot, alert: 'Você não tem permissão para aprovar este lote.'
    end
  end
  

  def show
    @items = @auction_lot.products.group(:product_model).count
    @highest_bid = @auction_lot.bids.maximum(:amount)
  end
  
  def edit; end

  def update
    auction_param
      if @auction_lot.update(auction_param)
        redirect_to @auction_lot, notice: "Lote atualizado com sucesso!"
      else
        flash[:alert] = "Não foi possível atualizar o lote."
        render 'edit'
      end
  end

  def create
    @auction_lot = AuctionLot.new(auction_param)
    @auction_lot.user = current_user
    if @auction_lot.save
      redirect_to root_path, notice: "Lote cadastrado com sucesso!"
    else
      flash[:alert] = "Lote não cadastrado."
      render 'new'
    end
  end

  def destroy
    @auction_lot.destroy
    if @auction_lot.destroy
      redirect_to root_path, notice: "Lote removido com sucesso!"
    else
      flash[:alert] = 'Não foi possível remover o Lote'
      render 'show'
    end
  end


  def add_product
    @auction_lot = AuctionLot.find(params[:id])
    @product = Product.find(params[:product_id])
    if @product.update(auction_lot_id: @auction_lot.id)
      redirect_to @auction_lot,  notice: 'Produto adicionado com sucesso.'
    else
      redirect_to @auction_lot, notice: 'Produto já existe em outro lote.'
    end
  end

  def remove_product
    @auction_lot = AuctionLot.find(params[:id])
    @product = @auction_lot.products.find_by(id: params[:product_id])
    if @product.try(:update, auction_lot_id: nil)
      redirect_to @auction_lot, notice: 'Produto removido com sucesso.'
    else
      redirect_to @auction_lot, notice: 'Não foi possível remover o produto.'
    end
  end

  def close_or_cancel
    @auction_lot = AuctionLot.find(params[:id])
    if @auction_lot.bids.count > 0
        @auction_lot.update(status: :closed)
    else
        @auction_lot.update(status: :cancelled)
    end
    redirect_to admin_auction_lot_path(@auction_lot)
  end

  

 
  private
  def expire_lots
    AuctionLot.expire_lots
  end

  def check_status
    @auction_lot = AuctionLot.find(params[:id])
    unless @auction_lot.status == 'pending'
      redirect_to @auction_lot, notice: 'Os itens só podem ser alterados enquanto seu status é "aguardando aprovação".'
    end
  end

  def set_auction
    @auction_lot = AuctionLot.find(params[:id])
  end

  def auction_param
    params.require(:auction_lot).permit(:code, :start_date, :limit_date, :value_min, :diff_min, :status, :product_ids)
  end 
end

