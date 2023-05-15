require 'rails_helper'

describe "Usuário cadastra uma categoria" do
  it "a partir do menu" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    
    login_as user
    visit root_path
    

    expect(page).not_to have_field('Categoria')
  end

  it "como Admin, e vê detalhes" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    Category.create!(name: "Esportes")
    
    login_as user
    visit root_path
    click_on 'Categoria'
    

    expect(page).to have_link "Nova Categoria"
    expect(page).to have_content "Categorias cadastradas:"
    expect(page).to have_content "Esportes"
    expect(page).to have_link "Voltar"
  end

  it "como Admin, com sucesso" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as user
    visit root_path
    click_on 'Categoria'
    click_on 'Nova Categoria'
    fill_in "Nome",	with: "Ferramentas"
    click_on 'Criar'

    expect(page).to have_content 'Categoria cadastrada com sucesso.'
  end

  it "como ADMIN, e com dados em branco" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as user
    visit root_path
    click_on 'Categoria'
    click_on 'Nova Categoria'
    fill_in "Nome",	with: ""
    click_on 'Criar'

    expect(page).to have_content 'Categoria não cadastrada.'
    expect(page).to have_content 'Nome não pode ficar em branco' 
  end
  
end