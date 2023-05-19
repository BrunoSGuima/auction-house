require 'rails_helper'

describe "Visitante" do
  it "não autenticado visita tela de lotes vencedores" do
  
    visit root_path
    visit winner_auction_lots_path
  
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
    expect(current_path).to eq new_user_session_path 
  end

  it "não autenticado visita tela de lotes favoritos" do
  
    visit root_path
    visit favorites_auction_lots_path
  
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
    expect(current_path).to eq new_user_session_path 
  end

  it "não autenticado visita tela de usuários cadastrados" do
  
    visit root_path
    visit users_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de lotes expirados" do
  
    visit root_path
    visit expired_auction_lots_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de perguntas" do
  
    visit root_path
    visit questions_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de edição de perguntas" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    question = Question.create!(user: user, auction_lot: lot, question_text: "teste?")

  
    visit root_path
    visit edit_question_path(question)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de novas perguntas" do
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: admin )
  
    visit root_path
    visit new_auction_lot_question_path(lot)
  
    expect(page).to have_content 'Para continuar, faça login ou registre-se'
    expect(current_path).to eq new_user_session_path 
  end

  it "não autenticado visita tela de categorias" do
  
    visit root_path
    visit categories_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de editar categorias" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    cat = Category.create!(name: "Esportes")
  
    visit root_path
    visit edit_category_path(cat)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de novas categorias" do
  
    visit root_path
    visit new_category_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela novos modelos de produtos" do
  
    visit root_path
    visit new_product_model_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela edição de modelos de produtos" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                        category: category)
  
    visit root_path
    visit edit_product_model_path(pm)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de novos produtos" do
  
    visit root_path
    visit new_product_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de novos lotes" do
  
    visit root_path
    visit new_auction_lot_path
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end

  it "não autenticado visita tela de edição de lotes" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now , limit_date: 5.days.from_now, 
                      value_min: 100, diff_min: 50, status: 'approved', user: user)
  
    visit root_path
    visit edit_auction_lot_path(auction)
  
    expect(page).to have_content 'Permissão negada'
    expect(current_path).to eq root_path 
  end
end



