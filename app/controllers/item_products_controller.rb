class ItemProductsController < ApplicationController
  before_action :set_item_product, only: [:destroy]

  def destroy
    @item_product = ItemProduct.find(params[:id])
    @auction_lot = @item_product.auction_lot
    @item_product.destroy
  
    redirect_to auction_lot_path(@auction_lot), notice: 'Item removido com sucesso.'
  end
  
  

  private

  def set_item_product
    @item_product = ItemProduct.find(params[:id])
  end
end

