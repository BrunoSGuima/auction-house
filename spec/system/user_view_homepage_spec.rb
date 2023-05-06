require 'rails_helper'

describe "Usuário visita tela inicial" do
  it "e vê o nome da app" do
  
    visit root_path
  
    expect(page).to have_content 'Leilão de Estoque'
  end

  it 'e vê os lotes cadastrados' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'pending', user: user )

    visit root_path

    expect(page).not_to have_content 'Não existem lotes cadastrados'
    expect(page).to have_content 'A12B34'
    expect(page).to have_content 'Pendente'
    end

    it 'e não vê galpões cadastrados' do
  
      visit root_path
  
      expect(page).to have_content 'Não existem lotes cadastrados'
      end
end
