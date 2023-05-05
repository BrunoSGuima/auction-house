class ProductModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @categories = Category.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end
  

  private
  def authorize_admin
    if current_user.role != "admin"
      redirect_to root_path, alert: "Permissão negada"
    end
  end

  def product_model_params
    params.require(:product_model).permit(:name, :description, :weight, :width, 
                                             :height, :depth, :category_id, :image_url)
  end
end