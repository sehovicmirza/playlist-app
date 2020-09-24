class ChangeColumnName < ActiveRecord::Migration
  def change
      rename_column :items, :votes, :rank
  end
end
