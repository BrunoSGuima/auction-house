class AuctionLotsController < ApplicationController
  before_action :check_status, only: [:remove_product, :add_product]
  before_action :set_auction, only: [:edit, :update, :show, :destroy, :approve, :remove_product, :add_product, 
                                      :favorite, :unfavorite, :question_lot, :close_or_cancel ]
  before_action :expire_lots, only: [:show, :edit, :update]
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy, :expired]
  before_action :authenticate_user!, only: [:favorites, :winner]

 
  def new
    @auction_lot = AuctionLot.new
  end

  def approve
    if current_user && current_user.admin? && current_user != @auction_lot.user
      if @auction_lot.approve_by(current_user)
        redirect_to @auction_lot, notice: 'Lote aprovado com sucesso!'
      else
        redirect_to @auction_lot, alert: 'Não foi possível aprovar o lote.'
      end
    else
      redirect_to @auction_lot, alert: 'Você não tem permissão para aprovar este lote.'
    end
  end
  
  def winner
    @closed_auction_lots = AuctionLot.where(status: AuctionLot.statuses[:closed])
  end
  

  def show
    @items = @auction_lot.products.group(:product_model).count
    @highest_bid = @auction_lot.bids.maximum(:amount)
  end
  
  def edit; end

  def update
    if @auction_lot.status == "pending"
      if @auction_lot.update(auction_param)
        redirect_to @auction_lot, notice: "Lote atualizado com sucesso!"
      else
        flash[:alert] = "Não foi possível atualizar o lote."
        render 'edit'
      end
    else
      flash[:alert] = 'Só é permitido atualizar lotes com status: "Aguardando aprovação".'
      redirect_to @auction_lot
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
    if @auction_lot.status == "pending"
      if @auction_lot.destroy
        redirect_to root_path, notice: "Lote removido com sucesso!"
      else
        flash[:alert] = 'Não foi possível remover o lote'
        @items = @auction_lot.products.group(:product_model).count
        render 'show'
      end
    else
      flash[:alert] = 'Não é possível remover lotes aprovados'
      @items = @auction_lot.products.group(:product_model).count
      render 'show'
    end
  end

  def question_lot
    @questions = @auction_lot.questions.where(visible: true)
  end
  
  
  def add_product
    product_id = params[:product_id]
    if product_id.present?
      @product = Product.find(product_id)
      if @product.update(auction_lot_id: @auction_lot.id)
        redirect_to @auction_lot,  notice: 'Produto adicionado com sucesso.'
      else
        redirect_to @auction_lot, notice: 'Produto já existe em outro lote.'
      end
    else
      redirect_to @auction_lot, alert: 'Selecione um produto válido para adicionar.'
    end
  end

  def remove_product
    @product = @auction_lot.products.find_by(id: params[:product_id])
    if @product.try(:update, auction_lot_id: nil)
      redirect_to @auction_lot, notice: 'Produto removido com sucesso.'
    else
      redirect_to @auction_lot, notice: 'Não foi possível remover o produto.'
    end
  end

  def close_or_cancel
    if @auction_lot.bids.count > 0
        @auction_lot.update!(status: :closed)
    else
      if @auction_lot.products.any?
        @auction_lot.products.update_all(auction_lot_id: nil)
      end
        @auction_lot.update!(status: :canceled)
    end
    redirect_to expired_auction_lots_path
  end

  def expired
    @expired_auction_lots = AuctionLot.where(status: AuctionLot.statuses[:expired])
    @canceled_closed_auction_lots = AuctionLot.where(status: [AuctionLot.statuses[:canceled], AuctionLot.statuses[:closed]])
  end

  def favorite
    current_user.favorites << @auction_lot
    redirect_to @auction_lot
  end

  def unfavorite
    current_user.favorites.delete(@auction_lot)
    redirect_to @auction_lot
  end

  def favorites
    @favorites = current_user.favorites
  end

  def search
    @auction_lots = AuctionLot.joins(products: :product_model)
                              .where("auction_lots.code LIKE :search OR product_models.name LIKE :search", 
                                search: "%#{params[:search]}%").where(status: "approved").distinct
  end
  
  

 
  private
  def expire_lots
    AuctionLot.expire_lots
  end

  def check_status
    @auction_lot = AuctionLot.find(params[:id])
    unless @auction_lot.status == 'pending' || @auction_lot.status ==  'expired'
      redirect_to @auction_lot, notice: 'Os itens só podem ser alterados enquanto seu status é "aguardando aprovação" ou "expirado".'
    end
  end

  def set_auction
    @auction_lot = AuctionLot.find(params[:id])
  end

  def auction_param
    params.require(:auction_lot).permit(:code, :start_date, :limit_date, :value_min, :diff_min, :status, :product_ids)
  end 
end

