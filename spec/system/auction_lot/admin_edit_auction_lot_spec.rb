require 'rails_helper'

describe "Admin edita um galpão" do

  it "a partir da página de detalhes" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now, limit_date: 3.weeks.from_now, 
      value_min: 100, diff_min: 50, status: 'pending', user: user)


    login_as user
    visit root_path
    click_on 'A1CB34'
    click_on 'Editar'



    expect(page).to have_content('Editar Lote')
    expect(page).to have_field 'Código', with: "A1CB34"
    expect(page).to have_field 'Valor mínimo do lance', with: '100'
    expect(page).to have_field 'Diferença mínima do lance', with: '50'
    expect(page).to have_button 'Enviar'
  end

  it "com sucesso" do


    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '10/10/2050' , limit_date: '10/11/2050', 
                      value_min: 100, diff_min: 50, status: 'pending', user: user)


    login_as user
    visit root_path
    click_on 'A1CB34'
    click_on 'Editar'

    fill_in "Valor mínimo do lance",	with: '150'
    fill_in 'Data de início',	with: '10/10/2050'
    fill_in 'Diferença mínima do lance',	with: '100'
    click_on 'Enviar'
    

    expect(page).to  have_content "Lote atualizado com sucesso!"
    expect(page).to  have_content "Lote de leilão A1CB34"
    expect(page).to  have_content "Valor mínimo do lance: 150"
    expect(page).to  have_content "Data de início: 10/10/2050"
  end

  it "mantém os campos obrigatórios" do


    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now, limit_date: 3.weeks.from_now, 
                        value_min: 100, diff_min: 50, status: 'pending', user: user)


    login_as user
    visit root_path
    click_on 'A1CB34'

    click_on 'Editar'
    fill_in "Diferença mínima do lance",	with: ""
    fill_in "Valor mínimo do lance",	with: ""
    click_on 'Enviar'


    expect(page).to  have_content "Não foi possível atualizar o lote."
  end

  it "com lote aprovado" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '10/10/2050' , limit_date: '10/11/2050', 
                      value_min: 100, diff_min: 50, status: 'approved', user: user)


    login_as user
    visit root_path
    click_on 'A1CB34'
    click_on 'Editar'

    fill_in "Valor mínimo do lance",	with: '150'
    fill_in 'Data de início',	with: '10/10/2050'
    fill_in 'Diferença mínima do lance',	with: '100'
    click_on 'Enviar'
    

    expect(page).to  have_content 'Só é permitido atualizar lotes com status: "Aguardando aprovação".'
    expect(page).to  have_content "Lote de leilão A1CB34"
    expect(page).to  have_content "Valor mínimo do lance: 100"
    expect(page).to  have_content "Data de início: 10/10/2050"
    expect(page).to  have_content "Diferença mínima do lance: 50"
  end
  
  
end
