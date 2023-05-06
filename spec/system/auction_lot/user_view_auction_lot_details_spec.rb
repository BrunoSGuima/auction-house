require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'sem estar autenticado' do
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 50, status: 'pending' )

    
    visit root_path 
    click_on 'A12B34'

    expect(page).to have_content 'Data de início: 07/05/2023'
    expect(page).to have_content 'Data limite: 09/05/2023'
    expect(page).to have_content 'Valor mínimo do lance: 100'
    expect(page).to have_content 'Diferença mínima entre lances: 50'

  end

  it 'e volta para a tela inicial' do
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 100, status: 'pending' )

    visit root_path 
    click_on 'A12B34'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)

  end

  it 'como ADMIN' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 500, status: 'pending')

    login_as(user)
    visit root_path 
    click_on 'A12B34'

    expect(page).to have_content 'Data de início: 07/05/2023'
    expect(page).to have_content 'Data limite: 09/05/2023'
    expect(page).to have_content 'Valor mínimo do lance: 100'
    expect(page).to have_content 'Diferença mínima entre lances: 50'

  end


end