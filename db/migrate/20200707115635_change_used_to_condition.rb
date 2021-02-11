class ChangeUsedToCondition < ActiveRecord::Migration[6.0]
  def change
    rename_column :stocks, :used, :condition
  end
end
