require 'rails_helper'

describe "Admin adiciona novos itens disponiveis" do

  it "com sucesso" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    second_pm = ProductModel.create!(name: 'Tv 50', description: 'TV Samsung de 50 polegadas', weight: 9000, width: 80, height: 55, depth: 20, 
                                category: category)
    auction = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now, limit_date: 2.weeks.from_now, 
                          value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as user
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
    click_on 'Adicionar Item'
    select 'Tv 32', from: 'Produto'
    click_on 'Adicionar'
    click_on 'Adicionar Item'
    select 'Tv 32', from: 'Produto'
    click_on 'Adicionar'
    click_on 'Adicionar Item'
    select 'Tv 50', from: 'Produto'
    click_on 'Adicionar'



    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Tv 32'
    expect(page).to have_content 'Quantidade de produtos disponíveis: 2'
    expect(page).to have_content 'Tv 50'
    expect(page).to have_content 'Quantidade de produtos disponíveis: 1'
  end
    
end
