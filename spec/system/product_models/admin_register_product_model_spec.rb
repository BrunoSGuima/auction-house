require 'rails_helper'

describe "Admin registra um modelo de produto" do
  it "com sucesso" do
    category = Category.create!(name: "Eletrônicos")
    second_category = Category.create!(name: "Esportes")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32 polegadas'
    fill_in 'Descrição', with: 'Tv LED Samsung'
    fill_in 'Peso', with: 8000
    fill_in 'Largura', with: 70
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 10
    select 'Esportes', from: 'product_model_category_id'
    attach_file 'Imagem', Rails.root.join("spec/support/imgs/TVSamsung32.jpg")
    click_on 'Enviar'
    
    
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 32 polegadas'
    expect(page).to have_content 'ABC1234567'
    expect(page).to have_content 'Descrição: Tv LED Samsung'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
    expect(page).to have_content 'Esportes'
    expect(page).to have_css ("img[src*='TVSamsung32']")
  end

  it "deve preencher todos os campos" do
    Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as(user)
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content  'Não foi possível cadastrar o produto'
  end
end