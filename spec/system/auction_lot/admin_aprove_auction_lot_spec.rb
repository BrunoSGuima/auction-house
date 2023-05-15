require 'rails_helper'

describe "Admin acessa e aprova lote" do
  it 'e lote criado não tem botão de aprovação' do
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')

    login_as user
    visit root_path
    click_on 'Cadastrar Lotes'
		fill_in 'Código',	with: 'A1CB34'
		fill_in 'Data de início',	with: '11/07/2040'
		fill_in 'Data limite',	with: '20/07/2040' 
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
		fill_in 'Data de início',	with: '11/07/2040'
		fill_in 'Data limite',	with: '20/07/2040' 
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
		fill_in 'Data de início',	with: '11/07/2040'
		fill_in 'Data limite',	with: '20/07/2040' 
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

describe "Admin acessa lotes expirados" do
  it "na página principal" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.new(code: 'A1CB34', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                          value_min: 100, diff_min: 50, status: 'expired', user: user)
    auction.save(validate: false)
    
    login_as user
    visit root_path
    click_on "Lotes Expirados"

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_content (auction.code)
    expect(page).to have_button "Encerrar/Cancelar lote" 
  end

  it "e cancela lote expirado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    pm = ProductModel.create!(name: 'Tv 32', description: 'TV Samsung de 32 polegadas', weight: 8000, width: 70, height: 45, depth: 10, 
                              category: category)
    auction = AuctionLot.new(code: 'A1CB34', start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                             value_min: 100, diff_min: 50, status: 'expired', user: user)
    second_auction = AuctionLot.new(code: "AAA333", start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                               value_min: 100, diff_min: 50, status: 'expired', user: user)                      
    auction.save(validate: false)
    second_auction.save(validate: false)
    a = Product.create!(product_model: pm, auction_lot: auction)

    
    login_as user
    visit root_path
    click_on "Lotes Expirados"
    within('div', text: 'A1CB34') do
      click_button('Encerrar/Cancelar lote')
    end
    auction.reload
    a.reload

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_content "A1CB34 | Cancelado" 
    expect(auction.status).to eq "canceled"
    expect(a.auction_lot).to be_nil 
  end

  it "e fecha lote expirado" do
    category = Category.create!(name: "Eletrônicos")
    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction = AuctionLot.new(code: 'A1CB34', start_date: 2.week.ago , limit_date: Date.tomorrow, 
                             value_min: 100, diff_min: 50, status: 'pending', user: user)
    second_auction = AuctionLot.new(code: "AAA333", start_date: 2.week.ago , limit_date: 1.weeks.ago, 
                               value_min: 100, diff_min: 50, status: 'expired', user: user)
    auction.save(validate: false)
    bid = Bid.create!(user: user, auction_lot: auction, amount: 120)
    auction.update(status: "expired")
    second_auction.save(validate: false)
    
    login_as user
    visit root_path
    click_on "Lotes Expirados"
    within('div', text: 'A1CB34') do
      click_button('Encerrar/Cancelar lote')
    end
    auction.reload

    expect(page).to have_content "Lotes Expirados:"
    expect(page).to have_content "Lotes Cancelados ou Fechados:"
    expect(page).to have_content "A1CB34 | Fechado" 
    expect(auction.status).to eq "closed"
  end
  
  
  
end