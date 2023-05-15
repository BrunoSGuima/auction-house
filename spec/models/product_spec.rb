require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "gera um número de série" do
    it "ao criar um Produto" do
      category = Category.create!(name: "Eletrônicos")
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                                category: category)
      product = Product.create!(product_model: pm)

      
      expect(product.serial_number.length).to eq 10
    end

    it "e não é modificado" do
      category = Category.create!(name: "Eletrônicos")
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                                category: category)
      second_pm = ProductModel.new(name: 'Soundbar 7.1 Surround', description: 'Caixa de som Samsung', weight: 3000, width: 80, height: 15, depth: 15, 
                                  category: category)
    
                                
      product = Product.create!(product_model: pm)
      original_serial_number = product.serial_number

      product.update!(product_model: second_pm)

      expect(product.serial_number).to eq(original_serial_number)
      
    end
  end
end
