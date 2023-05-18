require 'rails_helper'

describe "Admin bloqueia" do
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

  it "usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    find("#block_user_1").click
    

    expect(page).to have_button "Desbloquear"
    expect(page).to have_content "Usuário foi bloqueado." 
  end

  it "e desbloqueia usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171', status: "blocked")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    find("#unblock_user_1").click
    

    expect(page).to have_button "Bloquear"
    expect(page).to have_content "As restrições de acesso foram removidas." 
  end

  it "CPF do usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    find("#block_cpf_user_1").click
    

    expect(page).to have_button "Liberar"
    expect(page).to have_content "CPF bloqueado com sucesso" 
  end

  it "e desbloqueia CPF do usuário" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    BlockedCpf.create(cpf: '48625343171')
    
    login_as admin
    visit root_path
    click_on "Usuários Cadastrados"
    find("#unblock_cpf_user_1").click
    

    expect(page).to have_button "Bloquear CPF"
    expect(page).to have_content "CPF 48625343171 desbloqueado com sucesso!" 
  end

end