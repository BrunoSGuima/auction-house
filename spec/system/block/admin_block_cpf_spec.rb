require 'rails_helper'

describe "Admin bloqueia cpf" do
  it "a partir do menu" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    

    expect(current_path).to eq users_path 
    expect(page).to have_content "Nome"
    expect(page).to have_content "Email"
    expect(page).to have_content "CPF"   
    expect(page).to have_content "Bruno"
    expect(page).to have_content "bruno@email.com"
    expect(page).to have_content "48625343171"
    expect(page).to have_button "Bloquear" 
  end

  it "e bloqueia usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    click_on "Bloquear"
    

    expect(page).to have_button "Desbloquear"
    expect(page).to have_content "Usuário foi bloqueado." 
  end

  it "e desbloqueia usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171', status: "blocked")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    click_on "Desbloquear"
    

    expect(page).to have_button "Bloquear"
    expect(page).to have_content "As restrições de acesso foram removidas." 
  end

  it "e suspende usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    click_on "Suspender"
    

    expect(page).to have_button "Liberar"
    expect(page).to have_content "Usuário foi suspenso." 
  end

end