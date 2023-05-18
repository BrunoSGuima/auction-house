require 'rails_helper'

describe "Usuário" do

  it "autenticado visita tela de usuários cadastrados" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit users_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de lotes expirados" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit expired_auction_lots_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de perguntas" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit questions_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de edição de perguntas" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    question = Question.create!(user: user, auction_lot: lot)

    login_as user
    visit root_path
    visit edit_question_path(question)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

   it "autenticado visita tela de categorias" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit categories_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de editar categorias" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    cat = Category.create!(name: "Esportes")

    login_as user
    visit root_path
    visit edit_category_path(cat)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de novas categorias" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit new_category_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela novos modelos de produtos" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit new_product_model_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela edição de modelos de produtos" do
    category = Category.create!(name: "Eletrônicos")
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '38639395730')
    
    login_as user
    visit root_path
    visit edit_product_model_path(pm)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de novos produtos" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit new_product_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de novos lotes" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
  
    visit root_path
    visit new_auction_lot_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "autenticado visita tela de edição de lotes" do
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: '10/10/2050' , limit_date: '10/11/2050', 
                      value_min: 100, diff_min: 50, status: 'approved', user: admin)
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '38639395730')
    
    login_as user
  
    visit root_path
    visit edit_auction_lot_path(auction)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end
end