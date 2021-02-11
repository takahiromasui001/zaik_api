class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string     :name,                                       comment: '品名'
      t.string     :color_number,                               comment: '色番号'
      t.integer    :quantity,                                  comment: '残量'
      t.datetime   :manufacturing_date,                         comment: '製造年月日'
      t.boolean    :used,                                       comment: '中古'
      t.references :storehouse, null: false, foreign_key: true, comment: '倉庫ID'

      t.timestamps
    end
  end
end
