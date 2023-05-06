require 'rails_helper'

describe "Usuário vê produtos" do

  it "sem autenticação" do

    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(current_path).to  eq product_models_path
    expect(page).not_to have_content 'Cadastrar Novo'
  end
  
  it "se estiver autenticado como user" do

    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(current_path).to  eq product_models_path
    expect(page).not_to have_content 'Cadastrar Novo'
  end


  it "se estiver autenticado como admin" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Cadastrar Novo'
  end
end
  
describe "Usuário vê detalhes dos produtos" do
  
  it "como admin" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)
    code = pm.code


  
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"

    expect(page).to have_content 'Tv 32'
    expect(page).to have_content 'TV Samsung de 32 polegadas'
    expect(page).to have_content '8000'
    expect(page).to have_content '70'
    expect(page).to have_content '45'
    expect(page).to have_content '10'
    expect(page).to have_content "Eletrônicos"
    expect(page).to have_content code
  end

  it "como admin, e não existem produtos cadastrados" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content 'Nenhum produto cadastrado.'
  end

  it "como visitante não autenticado" do
    category = Category.create!(name: "Eletrônicos")
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)
    code = pm.code


    
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"

    expect(page).to have_content 'Tv 32'
    expect(page).to have_content 'TV Samsung de 32 polegadas'
    expect(page).to have_content '8000'
    expect(page).to have_content '70'
    expect(page).to have_content '45'
    expect(page).to have_content '10'
    expect(page).to have_content "Eletrônicos"
    expect(page).to have_content code
  end

  it "como usuário autenticado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)
    code = pm.code


    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"

    expect(page).to have_content 'Tv 32'
    expect(page).to have_content 'TV Samsung de 32 polegadas'
    expect(page).to have_content '8000'
    expect(page).to have_content '70'
    expect(page).to have_content '45'
    expect(page).to have_content '10'
    expect(page).to have_content "Eletrônicos"
    expect(page).to have_content code

  end

end
