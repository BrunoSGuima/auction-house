class ProductModelsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_admin, only: [:new, :create, :edit, :update]
  
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
      @categories = Category.all
      flash.now[:notice] = 'Não foi possível cadastrar o produto'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def edit
    @product_model = ProductModel.find(params[:id])
    @categories = Category.all
  end

  def update
    product_model_params
      if @product_model.update(product_model_params)
        redirect_to @product_model, notice: "Produto atualizado com sucesso!"
      else
        flash[:notice] = "Não foi possível atualizar o Produto."
        render 'edit'
      end
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
