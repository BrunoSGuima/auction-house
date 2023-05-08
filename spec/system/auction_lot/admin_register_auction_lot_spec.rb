require 'rails_helper'

describe "Admin cadastra um lote" do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as(user)
    visit root_path
    click_on 'Cadastrar Lotes'

    expect(page).to have_field 'Código'
    expect(page).to have_field 'Data de início'
    expect(page).to have_field 'Data limite'
    expect(page).to have_field 'Valor mínimo do lance'
    expect(page).to have_field 'Diferença mínima do lance'
    expect(page).to have_button 'Enviar'

  end

  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
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
  end

  
  it "com dados incompletos" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: ''
		fill_in 'Data de início',	with: ''
		fill_in 'Data limite',	with: '' 
		fill_in 'Valor mínimo do lance',	with: ''
		fill_in 'Diferença mínima do lance',	with: ''
		click_on 'Enviar'


    expect(current_path).to eq auction_lots_path
    expect(page).to  have_content 'Código: não pode ficar em branco'
    expect(page).to  have_content "Data de início: não pode ficar em branco"
    expect(page).to  have_content "Data limite: não pode ficar em branco"
    expect(page).to  have_content "Valor mínimo do lance: não pode ficar em branco"
    expect(page).to  have_content "Diferença mínima do lance: não pode ficar em branco"
  end

  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as(user)
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: '123456'
		fill_in 'Data de início',	with: '11/07/2024'
		fill_in 'Data limite',	with: '20/07/2024' 
		fill_in 'Valor mínimo do lance',	with: 100
		fill_in 'Diferença mínima do lance',	with: 50
		click_on 'Enviar'

		expect(page).to have_content 'o código deve ser composto por 3 letras e 6 caracteres'
  end
  
end
