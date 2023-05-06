require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "#valid?" do
    context "presence" do
      it "false quando o nome está vazio" do

        category = Category.create(name:'')  
        result = category.valid?
        expect(result).to  eq false
      end

      it "false quando a categoria já existe" do

        category = Category.create(name:'Esportes') 
        second_category = Category.create(name:'Esportes')
        
        expect(second_category.valid?).to  eq false
          
      end
    end
  end
end
