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


end