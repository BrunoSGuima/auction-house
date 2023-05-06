class CreateAuctionLots < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_lots do |t|
      t.string :code
      t.datetime :start_date
      t.datetime :limit_date
      t.integer :value_min
      t.integer :diff_min

      t.timestamps
    end
  end
end
