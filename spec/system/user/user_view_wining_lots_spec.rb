require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Usuário acessa página de lotes vencedores" do
  it "através do menu" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
        
    login_as user
    visit root_path

    expect(page).to have_link "Lotes Vencedores"
  end

  it "e consulta lote vencedor" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '38639395730')
    auction = AuctionLot.create!(code: "AAA333", start_date: Date.today  , limit_date: 2.days.from_now, 
      value_min: 100, diff_min: 50, status: 'closed', user: admin)
      bid = Bid.create!(user: user, auction_lot: auction, amount: 120)
    
    login_as user
    visit root_path
    click_on "Lotes Vencedores"

    expect(page).to have_content "AAA333"
    expect(page).to have_content "Parabéns! Você é o vencedor deste lote!"
    expect(page).to have_content "Usuário vencedor: Bruno" 
  end
end