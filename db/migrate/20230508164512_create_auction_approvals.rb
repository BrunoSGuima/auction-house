class CreateAuctionApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :auction_approvals do |t|
      t.references :auction_lot, null: false, foreign_key: true
      t.references :approved_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

