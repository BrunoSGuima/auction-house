class CreateBlockedCpfs < ActiveRecord::Migration[7.0]
  def change
    create_table :blocked_cpfs do |t|
      t.string :cpf
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
