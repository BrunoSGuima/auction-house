require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe "#valid?" do
    it "nome é obrigatório" do
      category = Category.create!(name: "Eletrônicos")
      pm = ProductModel.new(name: '', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
        category: category)

      result = pm.valid?

      expect(result).to eq false 
    end

    it "description é obrigatorio" do
      category = Category.create!(name: "Eletrônicos")
      pm = ProductModel.new(name: 'TV 32', description: '', weight: 8000, width: 70, height: 45, depth: 10, 
        category: category)

      result = pm.valid?

      expect(result).to eq false 
    end
    
    
  end
  
  describe "gera um código aleatório e único" do
    it "ao criar um novo produto" do
      category = Category.create!(name: "Eletrônicos")
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      pm = ProductModel.new(name: 'TV 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                            category: category)
      second_pm = ProductModel.new(name: 'Soundbar 7.1 Surround', description: 'Caixa de som Samsung', weight: 3000, width: 80, height: 15, depth: 15, 
                              category: category)

      pm.save!
      second_pm.save!
      result = pm.code

      expect(result).not_to be_empty
      expect(result.length).to eq 10
      expect(second_pm.code).not_to eq pm.code 
        
    end

    

    it "e não deve ser modificado" do
      category = Category.create!(name: "Eletrônicos")
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      pm = ProductModel.new(name: 'TV 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                            category: category)

      pm.save!
      original_code = pm.code

      pm.update!(name: "TV LG")

      expect(pm.code).to eq(original_code)
    end

   
  end
end
