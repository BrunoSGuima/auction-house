require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Admin acessa lotes expirados" do
  it "na página principal" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    travel_to 1.week.ago do
      AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 2.days.from_now, 
        value_min: 100, diff_min: 50, status: 'approved', user: user)
    end

    
    login_as user
    visit root_path
    click_on "Lotes Expirados"

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_button "Encerrar/Cancelar lote" 
  end

  it "e cancela lote expirado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)

    travel_to 1.week.ago do
      auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 2.days.from_now, 
                        value_min: 100, diff_min: 50, status: 'approved', user: user, id: "1")
      AuctionLot.create!(code: "AAA333", start_date: Date.today  , limit_date: 2.days.from_now, 
                     value_min: 100, diff_min: 50, status: 'approved', user: user)
      Product.create!(product_model: pm, auction_lot: auction, id: "1")
    end

    auction = AuctionLot.find(1)
    a = Product.find(1)

    login_as user
    visit root_path
    click_on "Lotes Expirados"
    within('div', text: 'A1CB34') do
      click_button('Encerrar/Cancelar lote')
    end
    auction.reload
    a.reload

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_content "A1CB34 | Cancelado" 
    expect(auction.status).to eq "canceled"
    expect(a.auction_lot).to be_nil 
  end

  it "e fecha lote expirado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    travel_to 1.week.ago do
      auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 2.days.from_now, 
                        value_min: 100, diff_min: 50, status: 'approved', user: user, id: "1")
      AuctionLot.create!(code: "AAA333", start_date: Date.today  , limit_date: 2.days.from_now, 
                     value_min: 100, diff_min: 50, status: 'approved', user: user)
      bid = Bid.create!(user: user, auction_lot: auction, amount: 120)
    end

    auction = AuctionLot.find(1)
    
    login_as user
    visit root_path
    click_on "Lotes Expirados"
    within('div', text: 'A1CB34') do
      click_button('Encerrar/Cancelar lote')
    end
    auction.reload

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_content "A1CB34 | Fechado" 
    expect(auction.status).to eq "closed"
  end
  
  
  
end