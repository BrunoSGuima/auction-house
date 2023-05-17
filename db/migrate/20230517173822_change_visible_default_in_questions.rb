class ChangeVisibleDefaultInQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :questions, :visible, from: nil, to: true
  end
end
