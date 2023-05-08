require 'rails_helper'

describe "Admin cadastra um lote" do
  it 'e lote aguarda aprovação' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as user
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: 'A1CB34'
		fill_in 'Data de início',	with: '11/07/2024'
		fill_in 'Data limite',	with: '20/07/2024' 
		fill_in 'Valor mínimo do lance',	with: 100
		fill_in 'Diferença mínima do lance',	with: 50
		click_on 'Enviar'

		expect(current_path).to eq root_path
    expect(page).to  have_content 'Lote cadastrado com sucesso!'
		expect(page).to have_content 'Lote: A1CB34'
    expect(page).to have_content 'Aguardando aprovação'
    expect(page).to have_content 'Lotes futuros:'
  end

  it 'e entra no lote criado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as user
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: 'A1CB34'
		fill_in 'Data de início',	with: '11/07/2024'
		fill_in 'Data limite',	with: '20/07/2024' 
		fill_in 'Valor mínimo do lance',	with: 100
		fill_in 'Diferença mínima do lance',	with: 50
		click_on 'Enviar'
    click_on 'A1CB34'

		expect(page).to  have_content 'Usuário responsável pelo cadastro: '
		expect(page).to have_content 'Bruno - bruno@leilaodogalpao.com.br - ADMIN'
    expect(page).not_to have_button 'Aprovar lote' 
  end

  it 'e outro admin acessa o lote criado' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    second_user = User.create!(name: 'Jessica', email: 'jessica@leilaodogalpao.com.br', password: 'password', cpf: '62185264702')

    login_as user
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: 'A1CB34'
		fill_in 'Data de início',	with: '11/07/2024'
		fill_in 'Data limite',	with: '20/07/2024' 
		fill_in 'Valor mínimo do lance',	with: 100
		fill_in 'Diferença mínima do lance',	with: 50
		click_on 'Enviar'
    click_on 'Sair'
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

    login_as user
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: 'A1CB34'
		fill_in 'Data de início',	with: '11/07/2024'
		fill_in 'Data limite',	with: '20/07/2024' 
		fill_in 'Valor mínimo do lance',	with: 100
		fill_in 'Diferença mínima do lance',	with: 50
		click_on 'Enviar'
    click_on 'Sair'
    login_as(second_user)
    visit root_path
    click_on 'A1CB34'
    click_on 'Aprovar Lote'

    expect(page).to have_content 'Usuário responsável pelo cadastro: Bruno - bruno@leilaodogalpao.com.br'
    expect(page).to have_content 'Lote aprovado com sucesso!'
    expect(page).to have_content 'Aprovado por: Jessica - jessica@leilaodogalpao.com.br'
    expect(page).to have_content 'Status: Aprovado'
  end
end