require 'rails_helper'

describe "Admin acessa e edita modelo de produto" do

  it "a partir da página de produtos" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)


    login_as user 
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"
    click_on 'Editar'

    expect(page).to have_content('Editar Produto')
    expect(page).to have_field 'Nome:', with: "Tv 32"
    expect(page).to have_field 'Descrição:', with: 'TV Samsung de 32 polegadas'
    expect(page).to have_field 'Peso:', with: 8000
    expect(page).to have_field 'Largura:', with: 70
    expect(page).to have_field 'Altura:', with: 45
    expect(page).to have_field 'Profundidade:', with: 10
    expect(page).to have_content 'Categoria: Eletrônicos'
    expect(page).to have_button 'Enviar'
  end

  it "como sucesso" do
    category = Category.create!(name: "Eletrônicos")
    Category.create!(name: "Televisores")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)

    login_as user 
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"
    click_on 'Editar'
    fill_in 'Nome', with: 'Tv 40'
    fill_in 'Peso', with: '5000'
    fill_in 'Altura', with: '55'
    select 'Televisores', from: "product_model_category_id"
    click_on 'Enviar'

    expect(page).to have_content 'Produto atualizado com sucesso!'
    expect(page).to have_content 'Nome: Tv 40'
    expect(page).to have_content 'Descrição: TV Samsung de 32 polegadas'
    expect(page).to have_content 'Peso: 5000'
    expect(page).to have_content 'Dimensão: 70cm x 55cm x 10cm'
    expect(page).to have_content 'Categoria: Televisores'
  end

  it "como dados incompletos" do
    category = Category.create!(name: "Eletrônicos")
    Category.create!(name: "Televisores")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)

    login_as user 
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on "Tv 32"
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: '5000'
    fill_in 'Altura', with: '55'
    select 'Televisores', from: "product_model_category_id"
    click_on 'Enviar'

    expect(page).not_to have_content 'Produto atualizado com sucesso!'
    expect(page).to have_content 'Não foi possível atualizar o Produto.'
    expect(current_path).to eq product_model_path(pm)  

  end
end