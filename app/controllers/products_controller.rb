class ProductsController < ApplicationController
  before_action :authorize_admin, only: [:new, :create]

  def create
    @product = Product.new(product_params)
    @product.auction_lot = @auction_lot
    if @product.save
      redirect_to product_models_path
    else
      render :new
    end
  end
  
  def new
    @product = Product.new()
    @products = ProductModel.all
  end

  def product_model_name
    product_model.name
  end

  private
  def product_params
    params.require(:product).permit(:product_model_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end