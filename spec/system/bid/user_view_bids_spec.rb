require 'rails_helper'

describe "Usuário visita tela de bids" do
  it "com sucesso" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 1.week.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Bid.create!(user: user, auction_lot: auction, amount: 500)
    visit root_path
    click_on auction.code
    click_on "Ver Lances"


    expect(page).to have_content 'Lances para o Lote A1CB34'
    expect(page).to have_content 'Usuário'
    expect(page).to have_content 'Valor do Lance'
    expect(page).to have_content 'Data do Lance'
    expect(page).to have_content '500'
    
  end

  it "e tenta fazer um lance com valor menor que mínimo" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 1.week.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Bid.create!(user: user, auction_lot: auction, amount: 500)
    
    login_as user
    visit root_path
    click_on auction.code
    fill_in 'Valor total', with: 90
    click_on 'Criar Lance'

    expect(page).to have_content 'Não foi possível fazer o seu lance! Valor total deve ser maior que o lance mínimo.'
    expect(page).not_to have_content 'Seu lance foi feito com sucesso.'
  end

  it "e tenta fazer um lance com valor menor que diferença mínima" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 1.week.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Bid.create!(user: user, auction_lot: auction, amount: 500)
    
    login_as user
    visit root_path
    click_on auction.code
    fill_in 'Valor total', with: 140
    click_on 'Criar Lance'

    expect(page).to have_content 'Não foi possível fazer o seu lance! Valor total deve ser maior que o lance atual somado com a diferença mínima.'
    expect(page).not_to have_content 'Seu lance foi feito com sucesso.'
  end

  it "e faz um lance" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 1.week.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Bid.create!(user: user, auction_lot: auction, amount: 120)
    
    login_as(user)
    visit root_path
    click_on auction.code
    fill_in 'Valor total', with: 200
    click_on 'Criar Lance'
    

    expect(page).not_to have_content 'Não foi possível fazer o seu lance.'
    expect(page).to have_content 'Seu lance foi feito com sucesso.'
    expect(page).to have_content 'O maior lance atual: 200'
  end

  it "e faz um lance com o leilão aguardando aprovação" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 1.week.from_now, 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as(user)
    visit root_path
    click_on auction.code
    fill_in 'bid_amount', with: 500
    click_on 'Criar Lance'


    expect(page).to have_content 'Os lances não estão disponíveis.'
    expect(page).not_to have_content 'Seu lance foi feito com sucesso.'
    expect(page).not_to have_content 'O maior lance atual: 500'    
  end

  
  
  
  
  
end