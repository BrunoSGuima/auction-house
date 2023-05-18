require 'rails_helper'

describe "visitante faz busca" do
  it "a partir da página de exibição dos lotes" do

    visit root_path

    expect(page).to have_field("Buscar por lotes e produtos:")
    expect(page).to have_button("Buscar")
  end
  
  it "e encontra um lote e seus produtos" do
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '38639395730')
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: admin)
    second_auction = AuctionLot.create!(code: 'A2CB55', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
                            value_min: 100, diff_min: 50, status: 'approved', user: admin)
    Product.create!(product_model: pm, auction_lot: auction)
    Product.create!(product_model: pm, auction_lot: second_auction)
    Product.create!(product_model: second_pm, auction_lot: second_auction)

    visit root_path
    fill_in "Buscar por lotes e produtos:", with: "Tv 32"
    click_on "Buscar"

    expect(page).to have_content "Resultados da pesquisa:"
    expect(page).to have_content "A1CB34"
    expect(page).to have_content "A2CB55"
    expect(page).to have_content "Produtos:"
    expect(page).to have_content "Tv 32"
    expect(page).to have_content "Tv 50"
  end

  it "e encontra um lote e seus produtos com uma pesquisa parcial" do
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '38639395730')
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    second_auction = AuctionLot.create!(code: 'A2CB55', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
                            value_min: 100, diff_min: 50, status: 'approved', user: user)
    Product.create!(product_model: pm, auction_lot: auction)
    Product.create!(product_model: pm, auction_lot: second_auction)
    Product.create!(product_model: second_pm, auction_lot: second_auction)

    visit root_path
    fill_in "Buscar por lotes e produtos:", with: "A1"
    click_on "Buscar"

    expect(page).to have_content "Resultados da pesquisa:"
    expect(page).to have_content "A1CB34"
    expect(page).to have_content "Tv 32"
  end
  
end
