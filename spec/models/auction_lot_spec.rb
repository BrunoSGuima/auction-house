require 'rails_helper'

RSpec.describe AuctionLot, type: :model do
  describe "#valid?" do
    context "presence" do      
    
      it "falso quando o código está em branco" do
        lot = AuctionLot.new(code: '', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
        value_min: 100, diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end

      it "falso quando o start_date está em branco" do
       lot = AuctionLot.new(code: 'A1CB34', start_date: '' , limit_date: 2.weeks.from_now, 
        value_min: 100, diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end
      
      it "falso quando o limit_date está em branco" do
        lot = AuctionLot.new(code: 'A1CB34', start_date: 1.week.from_now , limit_date: '', 
        value_min: 100, diff_min: 50)

        result = lot.valid?

        expect(result).to  eq false
      end

      it "falso quando o value_min está em branco" do
        lot = AuctionLot.new(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
        value_min: '', diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end
      
      it "falso quando o diff_min está em branco" do
        lot = AuctionLot.new(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
          value_min: 100, diff_min: '' )

        result = lot.valid?
        expect(result).to  eq false
      end

      it "data de inicio do lote não deve ser passada" do
        lot = AuctionLot.new(code: 'ABC123', start_date: Date.yesterday, limit_date: Date.today + 5.days, value_min: 100, diff_min: 10)
          
        lot.valid?
        result = lot.errors.include?(:start_date)
  
        expect(result).to be true 
        expect(lot.errors[:start_date]).to include(" deve ser futura.")
      end

      it "data limite do lote não deve ser menor que a data de inicio" do
        lot = AuctionLot.new(code: 'ABC123', start_date: 5.days.from_now, limit_date: 4.days.from_now)
  
        lot.valid?
        result = lot.errors.include?(:limit_date)
  
        expect(result).to be true 
        expect(lot.errors[:limit_date]).to include(" deve ser após o dia inicial.")
      end

      it "data de início do lote deve ser igual ou maior que hoje" do
        lot = AuctionLot.new(code: 'ABC123', start_date: Date.today)

        lot.valid?
  
        expect(lot.errors.include?(:start_date)).to be false 
      end
  

    end

    it "o código é unico" do
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                              value_min: 100, diff_min: 100, user: user)

      second_lot = AuctionLot.new(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                                    value_min: 200, diff_min: 50)


      expect(second_lot.valid?).to  eq false  
    end
    
    it "e não deve ser modificado" do
      user = User.create!(name: 'Bruno', email: 'bruno@leilaodogalpao.com.br', password: 'password', cpf: '48625343171')
      lot = AuctionLot.create!(code: 'A1CB34', start_date: 1.week.from_now , limit_date: 2.weeks.from_now, 
                              value_min: 100, diff_min: 100, user: user)
      original_code = lot.code

      lot.update!(value_min: 150)

      expect(lot.code).to eq(original_code)
    end

    
  end
  
end
