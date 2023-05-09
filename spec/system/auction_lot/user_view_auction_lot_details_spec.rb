require 'rails_helper'

describe 'Usuário vê detalhes de um lote' do
  it 'sem estar autenticado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
      value_min: 100, diff_min: 50, status: 'approved', user: user )
    


    
    visit root_path 
    click_on 'A1CB34'

    expect(page).to have_content 'Data de início: 20/06/2024'
    expect(page).to have_content 'Data limite: 29/06/2024'
    expect(page).to have_content 'Valor mínimo do lance: 100'
    expect(page).to have_content 'Diferença mínima do lance: 50'

  end

  it 'e volta para a tela inicial' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
      value_min: 100, diff_min: 100, status: 'approved', user: user )

    visit root_path 
    click_on 'A1CB34'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)

  end

  it 'como ADMIN' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
      value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as(user)
    visit root_path 
    click_on 'A1CB34'

    expect(page).to have_content 'Data de início: 20/06/2024'
    expect(page).to have_content 'Data limite: 29/06/2024'
    expect(page).to have_content 'Valor mínimo do lance: 100'
    expect(page).to have_content 'Diferença mínima do lance: 50'
  end

  it 'e vê itens do Lote' do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    al = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)
    AuctionItem.create!(product_model: pm, auction_lot: al, quantity: 20 )
    AuctionItem.create!(product_model: second_pm, auction_lot: al, quantity: 10 )
    
    login_as user
    visit root_path
    click_on al.code

    expect(page).to have_content 'Itens do Lote'
    expect(page).to have_content '20 x Tv 32'
    expect(page).to have_content '10 x Tv 50'
  end

  it 'e os itens são criados no ItemProduct' do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    al = AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2024' , limit_date: '29/06/2024', 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)

    
    login_as user
    visit root_path
    click_on al.code
    click_on 'Adicionar Item'
    
    select 'Tv 32', from: 'Produto'
    fill_in 'Quantidade', with: 20
    click_on 'Gravar'
    
    expect(page).to have_content 'Itens do Lote'
    expect(page).to have_content '20 x Tv 32'
    expect(ItemProduct.count).to eq 20
    total = ItemProduct.where(product_model: pm, auction_lot: al).count 
    expect(total).to eq 20
  end
end