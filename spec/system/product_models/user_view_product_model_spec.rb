require 'rails_helper'

describe "Usuário vê produtos" do

  it "se estiver autenticado como user" do

    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(current_path).to  eq root_path
    expect(page).to have_content "Permissão negada"
    
  end


  it "se estiver autenticado como admin" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(current_path).to eq product_models_path
    
  end
  
  it "como admin" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    ProductModel.create!(name: 'TV 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        code: 'TV32-SAMSU-XPTO90' , category: category)
    ProductModel.create!(name: 'Soundbar 7.1 Surround', description: 'Caixa de som Samsung', weight: 3000, width: 80, height: 15, depth: 15, 
                          code: 'SO71-SAMSU-NOIZ77' , category: category)

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Eletrônicos'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content "Eletrônicos"
  end

  it "como admin, e não existem produtos cadastrados" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Nenhum produto cadastrado.'
    
  end

end
