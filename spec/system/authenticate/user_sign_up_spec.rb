require 'rails_helper'

describe "Usuário se autentica" do
  it "com sucesso" do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma Conta'
    fill_in "Nome",	with: "Maria"
    fill_in "CPF",	with: "33423256907" 
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar'

    expect(page).to  have_content 'maria@email.com'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    user = User.last
    expect(user.name).to eq "Maria"
  end

  it "e falha" do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma Conta'
    fill_in "Nome",	with: "Maria"
    fill_in "CPF",	with: "486000001" 
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar'

    expect(page).not_to  have_content 'maria@email.com'
    expect(page).not_to have_button 'Sair'
    expect(page).to have_content 'CPF INVÁLIDO!'
  end 
end

