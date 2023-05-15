require 'rails_helper'

describe "Admin remove um galpão" do
  it "com sucesso" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
      value_min: 100, diff_min: 50, status: 'pending', user: user)
    second_lot = AuctionLot.create!(code: 'A2B4C5', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now,  
        value_min: 200, diff_min: 50, user: user)

    login_as user
    visit root_path
    click_on 'A1CB34'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to  have_content "Lote removido com sucesso!"
    expect(page).not_to  have_content "A1CB34"
    expect(page).to  have_content "A2B4C5"
  end

   it "com status aprovado" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    auction_lot = AuctionLot.create!(code: 'A1CB34', start_date: 2.weeks.from_now , limit_date: 3.weeks.from_now, 
      value_min: 100, diff_min: 50, status: 'approved', user: user)


    login_as user
    visit root_path
    click_on 'A1CB34'
    click_on 'Remover'

    expect(current_path).to eq auction_lot_path(auction_lot)
    expect(page).to  have_content "Não é possível remover lotes aprovados"
    expect(page).to  have_content "A1CB34"
  end
end