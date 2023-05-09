class AuctionItemsController < ApplicationController
  def new
    @auction_lot = AuctionLot.find(params[:auction_lot_id])
    @auction_item = AuctionItem.new()
    @products = ProductModel.all
  end

def create
  @auction_lot = AuctionLot.find(params[:auction_lot_id])
  auction_item_params = params.require(:auction_item).permit(:product_model_id, :quantity)

  @auction_item = @auction_lot.auction_items.create(auction_item_params)
  @auction_item.quantity.times do
    ItemProduct.create!(auction_lot: @auction_lot, auction_item: @auction_item, product_model: @auction_item.product_model)
  end

  redirect_to @auction_lot, notice: 'Item adicionado com sucesso'
end

def destroy
  @item_product = ItemProduct.find(params[:id])
  @auction_lot = @item_product.auction_lot
  @item_product.destroy

  redirect_to auction_lot_path(@auction_lot), notice: 'Item removido com sucesso.'
end



end
