class ChangeBooleanToIntegerOfStocksCondition < ActiveRecord::Migration[6.0]
  def up
    change_column :stocks, :condition, :integer, comment: '使用状況'
  end

  # 変更前の状態
  def down
    change_column :stocks, :condition, :boolean, comment: '使用状況'
  end
end
