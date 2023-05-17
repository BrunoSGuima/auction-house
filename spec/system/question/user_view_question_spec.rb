require 'rails_helper'

describe "Usuário visita lote e" do
  it "vê botão de perguntas frequentes" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )

    visit root_path
    click_on "A1CB34"

    expect(page).to have_link "Perguntas Frequentes"
  end

  it "clica no botão de perguntas" do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
                            value_min: 100, diff_min: 100, status: 'approved', user: user )

    visit root_path
    click_on "A1CB34"
    click_on "Perguntas Frequentes"

    expect(page).to have_content "Não há perguntas neste lote."
  end

  it "em faz uma pergunta" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )

    login_as user
    visit root_path
    click_on "A1CB34"

    expect(page).to have_link "Dúvidas?"
    expect(page).to have_link "Perguntas Frequentes"
  end
    
  it "e faz uma pergunta" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )

    login_as user
    visit root_path
    click_on "A1CB34"
    click_on "Dúvidas?"
    fill_in 'Pergunta:', with: "Quero saber isso, isso, isso e isso."
    click_on "Enviar"

    expect(current_path).to eq auction_lot_path(lot)
    expect(page).to have_content "Pergunta feita com sucesso."
  end

  it "e consulta sua pergunta na página de perguntas" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    Question.create!(user: user, auction_lot: lot, question_text: "Quero saber isso, isso e isso.")

    login_as user
    visit root_path
    click_on "A1CB34"
    click_on "Perguntas Frequentes"

    expect(current_path).to eq question_lot_auction_lot_path(lot)
    expect(page).to have_content "Quero saber isso, isso e isso."
  end

  it "e não vê uma pergunta bloqueada" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    Question.create!(user: user, auction_lot: lot, question_text: "Quero saber isso, isso e isso.", visible: false)
    Question.create!(user: user, auction_lot: lot, question_text: "Quero tal e tal.")

    login_as admin
    visit root_path
    click_on "A1CB34"
    click_on "Perguntas Frequentes"
        
    expect(page).to have_content "Quero tal e tal."
    expect(page).not_to have_content "Quero saber isso, isso e isso."
  end

  it "e tenta fazer uma pergunta com a conta suspensa" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171', status: "suspended")
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )


    login_as user
    visit root_path
    click_on "A1CB34"
    click_on "Dúvidas"
        
    expect(page).to have_content "Sua conta está suspensa."
    expect(current_path).to eq auction_lot_path(lot)
  end
end

describe "Admin vê perguntas" do
  it "através do menu" do
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')

    login_as admin
    visit root_path
    
    expect(page).to have_link "Perguntas"   
  end

  it "e acessa" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    Question.create!(user: user, auction_lot: lot, question_text: "Quero saber isso, isso e isso.")

    login_as admin
    visit root_path
    click_on "Perguntas"
    
    expect(page).to have_link "Quero saber isso,..."
    expect(page).to have_content "Feita por: Bruno"
    expect(page).to have_content "Resposta: Ainda não respondida"
  end

  it "e responde uma pergunta" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    Question.create!(user: user, auction_lot: lot, question_text: "Quero saber isso, isso e isso.")

    login_as admin
    visit root_path
    click_on "Perguntas"
    click_on "Quero saber isso,..."
    click_on "Responder"
    fill_in 'Resposta:', with: "Isso e isso"
    click_on "Salvar"

    expect(page).to have_content "Resposta enviada com sucesso."
  end

  it "e oculta uma pergunta" do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password', cpf: '48625343171')
    admin = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '67428513847')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.day.from_now, limit_date: 3.days.from_now, 
      value_min: 100, diff_min: 100, status: 'approved', user: user )
    Question.create!(user: user, auction_lot: lot, question_text: "Quero saber isso, isso e isso.")

    login_as admin
    visit root_path
    click_on "Perguntas"
    click_on "Quero saber isso,..."
    click_on "Ocultar"
    
    expect(page).to have_content "Pergunta ocultada com sucesso"
    expect(page).to have_content "Pergunta Ocultada"
  end
end