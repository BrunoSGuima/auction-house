class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
      if @category.save
        redirect_to product_models_path, notice: "Categoria cadastrada com sucesso."
      else
        flash.now[:alert] = "Categoria não cadastrada."
        render 'new'
      end
  end
end