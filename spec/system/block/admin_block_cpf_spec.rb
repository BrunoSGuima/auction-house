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
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    click_on "Bloquear"
    click_on "Desbloquear"
    

    expect(page).to have_button "Bloquear"
    expect(page).to have_content "Usuário foi desbloqueado." 
  end

  # it "e usuário bloqueado tenta entrar" do
  #   user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171', status: 'blocked')
    
  #   login_as user
    
  #   expect(page).to have_content "Sua conta está bloqueada. Contate o suporte."
  #   expect(page).not_to have_content "Login efetuado com sucesso."  
  # end

  # it "e bloqueia apenas um usuário" do
  #   second_user = User.create!(name: 'Jose', email: 'Jose@email.com', password: 'password', cpf: '81164849662')
  #   user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
  #   admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
  #   login_as admin
  #   visit root_path
  #   click_on "Usuários Cadastrados"
  #   click_on "Bloquear"
    

  #   expect(page).to have_button "Desbloquear"
  #   expect(page).to have_content "Usuário foi bloqueado." 
  # end
end