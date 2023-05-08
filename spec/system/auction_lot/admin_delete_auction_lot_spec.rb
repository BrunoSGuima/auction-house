require 'rails_helper'

describe "Admin remove um galpão" do
  it "com sucesso" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A1CB34', start_date: '11/07/2024' , limit_date: '20/07/2024', 
      value_min: 100, diff_min: 50, status: 'pending', user: user)

    login_as(user)
    visit root_path
    click_on 'A1CB34'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to  have_content "Lote removido com sucesso!"
    expect(page).not_to  have_content "A1CB34"
  end

  it "com sucesso" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    lot = AuctionLot.create!(code: 'A1CB34', start_date: '11/07/2024' , limit_date: '20/07/2024', 
                             value_min: 100, diff_min: 100, user: user)

    second_lot = AuctionLot.create!(code: 'A2B4C5', start_date: '21/07/2024' , limit_date: '19/08/2024',  
                                  value_min: 200, diff_min: 50, user: user)


    login_as(user)
    visit root_path
    click_on 'A2B4C5'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to  have_content "A1CB34"
    expect(page).not_to  have_content "A2B4C5"
  end
end