require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Usuário clica em Favoritos" do
  it "e favorita um lote" do
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '46364622208')
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )
    
    login_as second_user
    visit root_path
    click_on "A1CB34"
    click_on "Adicionar aos Favoritos"

    expect(page).to have_button "Remover dos Favoritos"
    expect(page).not_to have_button "Adicionar aos Favoritos"
    expect(current_path).to eq auction_lot_path(auction)
  end

  it "e desfavorita um lote" do
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '46364622208')
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )
    
    login_as second_user
    visit root_path
    click_on "A1CB34"
    click_on "Adicionar aos Favoritos"
    click_on "Remover dos Favoritos"

    expect(page).not_to have_button "Remover dos Favoritos"
    expect(page).to have_button "Adicionar aos Favoritos"
    expect(current_path).to eq auction_lot_path(auction)
  end

  it "e consulta página de favoritos" do
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '46364622208')
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )
    
    login_as second_user
    visit root_path
    click_on "A1CB34"
    click_on "Adicionar aos Favoritos"
    click_on "Favoritos"


    expect(page).to have_content "Lote: A1CB34"
    expect(current_path).to eq favorites_auction_lots_path
  end

  it "e consulta página de favoritos após remover favoritos" do
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '46364622208')
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )
    
    login_as second_user
    visit root_path
    click_on "A1CB34"
    click_on "Adicionar aos Favoritos"
    click_on "Favoritos"
    click_on "A1CB34"
    click_on "Remover dos Favoritos"
    click_on "Favoritos"


    expect(page).not_to have_content "Lote: A1CB34"
  end

  it "e consulta página de favoritos com um lote expired" do
    second_user = User.create!(name: 'Bruno', email: 'bruno@email.com.br', password: 'password', cpf: '46364622208')

    travel_to 1.week.ago do
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                              value_min: 100, diff_min: 100, status: 'approved', user: user )
      login_as second_user
      visit root_path
      click_on "A1CB34"
      click_on "Adicionar aos Favoritos"
      click_on "Sair"
    end

    login_as second_user
    visit root_path
    click_on "Favoritos"
    
    expect(page).to have_content "Lote: A1CB34"
    expect(page).to have_css('.expired-message', text: "Este lote perdeu a validade")
  end
end
