require 'rails_helper'

describe "Admin edita um galpão" do

  it "a partir da página de detalhes" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 50, status: 'pending')


    login_as(user)
    visit root_path
    click_on 'A12B34'
    click_on 'Editar'



    expect(page).to have_content('Editar Lote')
    expect(page).to have_field 'Código', with: "A12B34"
    expect(page).to have_field 'Valor mínimo do lance', with: '100'
    expect(page).to have_field 'Diferença mínima do lance', with: '50'
    expect(page).to have_button 'Enviar'
  end

  it "com sucesso" do


    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 50, status: 'pending')


    login_as(user)
    visit root_path
    click_on 'A12B34'
    click_on 'Editar'

    fill_in "Valor mínimo do lance",	with: '150'
    fill_in 'Data de início',	with: '08/05/2023'
    fill_in 'Diferença mínima do lance',	with: '100'
    click_on 'Enviar'
    

    expect(page).to  have_content "Lote atualizado com sucesso!"
    expect(page).to  have_content "Lote A12B34"
    expect(page).to  have_content "Valor mínimo do lance: 150"
    expect(page).to  have_content "Data de início: 08/05/2023"
  end

  it "mantém os campos obrigatórios" do


    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
                        value_min: 100, diff_min: 50, status: 'pending')


    login_as(user)
    visit root_path
    click_on 'A12B34'

    click_on 'Editar'
    fill_in "Diferença mínima do lance",	with: ""
    fill_in "Valor mínimo do lance",	with: ""
    click_on 'Enviar'


    expect(page).to  have_content "Não foi possível atualizar o lote."
  end
  
  
end
