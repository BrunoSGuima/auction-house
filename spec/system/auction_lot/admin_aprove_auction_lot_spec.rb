require 'rails_helper'

describe "Admin acessa e aprova lote" do
  it 'e lote criado não tem botão de aprovação' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 3.days.from_now, 
                                value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as user
    visit root_path
    click_on 'A1CB34'


		expect(page).to  have_content 'Usuário responsável pelo cadastro: Bruno - bruno@leilaodogalpao.com.br'
    expect(page).not_to have_button 'Aprovar lote' 
  end

  it 'e outro admin acessa o lote criado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    second_user = User.create!(name: 'Jessica', email: 'jessica@leilaodogalpao.com.br', password: 'password', cpf: '62185264702')
    auction = AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as second_user
    visit root_path
    click_on 'A1CB34'

    expect(page).to  have_content 'Usuário responsável pelo cadastro: Bruno - bruno@leilaodogalpao.com.br'
    expect(page).to have_button 'Aprovar Lote'
    expect(page).to have_content 'Status: Aguardando aprovação'
  end

  it 'e outro admin aprova o lote criado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    second_user = User.create!(name: 'Jessica', email: 'jessica@leilaodogalpao.com.br', password: 'password', cpf: '62185264702')
    AuctionLot.create!(code: 'A1CB34', start_date: Date.today , limit_date: 3.days.from_now, 
                        value_min: 100, diff_min: 50, status: 'pending', user: user)


    login_as second_user
    visit root_path
    click_on 'A1CB34'
    click_on 'Aprovar Lote'

    expect(page).to have_content 'Usuário responsável pelo cadastro: Bruno - bruno@leilaodogalpao.com.br'
    expect(page).to have_content 'Lote aprovado com sucesso!'
    expect(page).to have_content 'Aprovado por: Jessica - jessica@leilaodogalpao.com.br'
    expect(page).to have_content 'Status: Aprovado'
  end
end
