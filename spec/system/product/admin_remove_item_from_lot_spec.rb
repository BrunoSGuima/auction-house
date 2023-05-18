require 'rails_helper'

describe "Admin remove produtos do pedido" do

  it "com sucesso" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    Product.create!(product_model: pm, auction_lot: auction )
    Product.create!(product_model: second_pm, auction_lot: auction)

    login_as user
    visit root_path
    click_on auction.code
    find("#product_1").click
    

    expect(current_path).to eq current_path
    expect(page).to have_content 'Produto removido com sucesso.'
    expect(page).not_to have_content 'Tv 32 - Quantidade: 1'
    expect(page).to have_content 'Tv 50 - Quantidade: 1'
  end

  it "de um lote com status de aprovado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Product.create!(product_model: pm, auction_lot: auction )
    Product.create!(product_model: second_pm, auction_lot: auction)

    login_as user
    visit root_path
    click_on auction.code
    find("#product_1").click

    

    expect(current_path).to eq current_path
    expect(page).to have_content 'Os itens só podem ser alterados enquanto seu status é "aguardando aprovação" ou "expirado".'
    expect(page).to have_content 'Tv 32 - Quantidade: 1'
    expect(page).to have_content 'Tv 50 - Quantidade: 1'
  end
end