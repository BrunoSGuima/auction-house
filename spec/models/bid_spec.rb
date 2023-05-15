require 'rails_helper'

RSpec.describe Bid, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  describe "#valid?" do
    it "o lance não pode ser após o ultimo segundo do encerramento do lote" do
      user = User.create!(name: 'Julia do Pão', email: 'julia@leilaodogalpao.com.br', password: '123456', cpf:'48625343171')
      u = User.create!(name: 'Julia Almeida', email: 'julia@yahoo.com', password: '123456', cpf:'89613797718')
      auction_lot = AuctionLot.new(code: 'A1CB34', start_date: 1.week.ago, limit_date: Date.yesterday.end_of_day, 
        value_min: 100, diff_min: 50, status: 'approved', user: user)
      auction_lot.save(validate: false)
      bid = nil
        
      
      travel_to Date.today.beginning_of_day do
        bid = Bid.new(user: u, auction_lot: auction_lot, amount: 200)
      end
      
      
      expect(bid).not_to be_valid
      expect(bid.errors[:base]).to include("O lance não pode ser feito após o encerramento do leilão.")
    end
  end

end
