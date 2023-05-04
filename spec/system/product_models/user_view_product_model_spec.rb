require 'rails_helper'

describe "Usuário vê modelos de produtos" do
  it "a partir do menu" do

    visit root_path
    click_on 'Produtos'

    expect(current_path).to eq product_models_path
    
  end
  
  it "com sucesso" do

    ProductModel.create!(name: 'TV 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        code: 'TV32-SAMSU-XPTO90' , category: 'Eletrônicos')
    ProductModel.create!(name: 'Soundbar 7.1 Surround', description: 'Caixa de som Samsung', weight: 3000, width: 80, height: 15, depth: 15, 
                          code: 'SO71-SAMSU-NOIZ77' , category: 'Eletrônicos')

    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Eletrônicos'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'Eletrônicos'
  end

  it "e não existem produtos cadastrados" do
    
    
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Nenhum produto cadastrado.'
    
  end

  
  
end
