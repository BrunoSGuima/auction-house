class RemoveCategoriesTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :categories
  end
end
