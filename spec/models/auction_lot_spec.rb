require 'rails_helper'

RSpec.describe AuctionLot, type: :model do
  describe "#valid?" do
    context "presence" do      
    
      it "false when code is empty" do
        lot = AuctionLot.new(code: '', start_date: '07/05/2023' , limit_date: '09/05/2023', 
        value_min: 100, diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end

      it "false when start_date is empty" do
       lot = AuctionLot.new(code: 'A12B34', start_date: '' , limit_date: '09/05/2023', 
        value_min: 100, diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end
      
      it "false when limit_date is empty" do
        lot = AuctionLot.new(code: 'A12B34', start_date: '07/05/2023' , limit_date: '', 
        value_min: 100, diff_min: 50)

        result = lot.valid?

        expect(result).to  eq false
      end

      it "false when value_min is empty" do
        lot = AuctionLot.new(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
        value_min: '', diff_min: 50 )

        result = lot.valid?

        expect(result).to  eq false
      end
      
      it "false when diff_min is empty" do
        # Arrange
        lot = AuctionLot.new(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
          value_min: 100, diff_min: '' )
        # Act
        result = lot.valid?
        # Assert
        expect(result).to  eq false
      end

    end

    it "false when code is already in use" do
      lot = AuctionLot.create!(code: 'A12B34', start_date: '09/05/2023' , limit_date: '11/05/2023', 
                              value_min: 100, diff_min: 100 )

      second_lot = AuctionLot.new(code: 'A12B34', start_date: '07/05/2023' , limit_date: '09/05/2023', 
                                    value_min: 200, diff_min: 50)


      expect(second_lot.valid?).to  eq false  
    end

    
  end
  
end
