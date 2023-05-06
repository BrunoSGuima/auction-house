require 'rails_helper'

describe "Usúario remove um galpão" do
  it "com sucesso" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    AuctionLot.create!(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
      value_min: 100, diff_min: 50, status: 'pending')

    login_as(user)
    visit root_path
    click_on 'A12B34'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to  have_content "Lote removido com sucesso!"
    expect(page).not_to  have_content "A12B34"
  end

  it "com sucesso" do

    user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
    lot = AuctionLot.create!(code: 'A12B34', start_date: '09/05/2023' , limit_date: '11/05/2023', 
                             value_min: 100, diff_min: 100 )

    second_lot = AuctionLot.create!(code: 'A2B4C5', start_date: '07/05/2023' , limit_date: '09/05/2023',  
                                  value_min: 200, diff_min: 50)


    login_as(user)
    visit root_path
    click_on 'A2B4C5'
    click_on 'Remover'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to  have_content "A12B34"
    expect(page).not_to  have_content "A2B4C5"
  end
end