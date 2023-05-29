require 'rails_helper'

describe "Admin clica edit em uma categoria" do
  it "com sucesso" do
    cat = Category.create!(name: "Eletrônicos")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as admin
    visit root_path
    click_on 'Categorias'
    find("#edit_category_#{cat.id}").click


    expect(page).to have_content 'Editar Categoria'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Salvar'
  end

  it "e edita a categoria com sucesso" do
    cat = Category.create!(name: "Eletrônicos")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as admin
    visit root_path
    click_on 'Categorias'
    find("#edit_category_#{cat.id}").click
    fill_in "Nome",	with: "Pesca"
    click_on "Salvar"


    expect(current_path).to  eq categories_path
    expect(page).to have_content 'Categoria atualizada com sucesso!'
    expect(page).to have_content 'Pesca'
  end

  it "e não consegue editar categoria" do
    cat = Category.create!(name: "Eletrônicos")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    
    login_as admin
    visit root_path
    click_on 'Categorias'
    find("#edit_category_#{cat.id}").click
    fill_in "Nome",	with: " "
    click_on "Salvar"


    expect(current_path).to eq category_path(cat)
    expect(page).to have_content 'Não foi possível atualizar a Categoria'
  end
end