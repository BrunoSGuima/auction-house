require 'rails_helper'

describe "Usuário adiciona itens ao pedido" do

  it "com sucesso" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    AuctionItem.create!(product_model: pm, auction_lot: auction, quantity: 20 )
    AuctionItem.create!(product_model: second_pm, auction_lot: auction, quantity: 10 )

    login_as(user)
    visit root_path
    click_on auction.code
    click_on 'Adicionar Item'
    select 'Tv 32', from: 'Produto'
    fill_in "Quantidade",	with: "8"
    click_on 'Gravar'

    expect(current_path).to eq auction_lot_path(auction.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Tv 32'
    
  end

  it "e não vê produtos de outro lote" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    al = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    second_al = AuctionLot.create!(code: 'ABC123', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                            value_min: 100, diff_min: 50, status: 'pending', user: user)
    AuctionItem.create!(product_model: pm, auction_lot: al, quantity: 20 )
    AuctionItem.create!(product_model: second_pm, auction_lot: second_al, quantity: 10 )

    login_as user
    visit root_path
    click_on al.code

    expect(page).to have_content 'Tv 32'
    expect(page).not_to have_content 'Tv 50'
    
  end
  
  
end
