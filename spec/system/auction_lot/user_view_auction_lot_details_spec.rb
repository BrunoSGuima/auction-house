require 'rails_helper'

describe 'Usuário vê detalhes de um lote' do
  it 'sem estar autenticado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2044' , limit_date: '29/06/2044', 
      value_min: 100, diff_min: 50, status: 'approved', user: user )
    


    
    visit root_path 
    click_on 'A1CB34'

    expect(page).to have_content 'Data de início: 20/06/2044'
    expect(page).to have_content 'Data limite: 29/06/2044'
    expect(page).to have_content 'Valor mínimo do lance: 100'
    expect(page).to have_content 'Diferença mínima do lance: 50'

  end

  it 'e volta para a tela inicial' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )

    visit root_path 
    click_on 'A1CB34'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end

describe 'Admin vê detalhes de um lote' do
  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '20/06/2044' , limit_date: '29/06/2044', 
      value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as(user)
    visit root_path 
    click_on 'A1CB34'

    expect(page).to have_content 'Data de início: 20/06/2044'
    expect(page).to have_content 'Data limite: 29/06/2044'
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
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'approved', user: user)
    Product.create!(product_model: pm, auction_lot: auction )
    Product.create!(product_model: second_pm, auction_lot: auction)
    

    visit root_path
    click_on auction.code

    expect(page).to have_content 'Itens no lote'
    expect(page).to have_content 'Tv 32 - Quantidade: 1'
    expect(page).to have_content 'Tv 50 - Quantidade: 1'
  end
end