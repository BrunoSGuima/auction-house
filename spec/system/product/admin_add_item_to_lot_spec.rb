require 'rails_helper'

describe "Usuário adiciona produtos ao pedido" do

  it "com sucesso" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    Product.create!(product_model: pm )
    Product.create!(product_model: second_pm)

    login_as(user)
    visit root_path
    click_on auction.code
    select 'Tv 32 - ID: 1', from: 'Produto'
    click_on 'Adicionar Produto'


    expect(current_path).to eq auction_lot_path(auction)
    expect(page).to have_content 'Produto adicionado com sucesso.'
    expect(page).to have_content 'Tv 32 - Quantidade: 1'
    
  end

  it "e não vê produtos de outro lote" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now, limit_date: 2.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    second_auction = AuctionLot.create!(code: 'A2CB54', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                            value_min: 100, diff_min: 50, status: 'pending', user: user)
    Product.create!(product_model: pm, auction_lot: auction )
    Product.create!(product_model: second_pm, auction_lot: second_auction)

    login_as user
    visit root_path
    click_on auction.code

    expect(page).to have_content 'Tv 32'
    expect(page).not_to have_content 'Tv 50'
    
  end

 
  
  
end
