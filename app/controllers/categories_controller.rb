class CategoriesController < ApplicationController
  before_action :authorize_admin, only: [:new, :create]
  before_action :set_category, only: [:edit, :update]
  

  def index
    @categories = Category.all
  end
  

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Categoria cadastrada com sucesso."
    else
      flash.now[:alert] = "Categoria não cadastrada."
      render 'new'
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Categoria atualizada com sucesso!"
    else
      flash[:notice] = "Não foi possível atualizar a Categoria"
      render 'edit'
    end
  end 

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
