class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :auction_lot, null: false, foreign_key: true
      t.references :admin, foreign_key: { to_table: :users }
      t.text :question_text
      t.text :response_text
      t.boolean :visible

      t.timestamps
    end
  end
end
