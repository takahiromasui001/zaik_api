class CreateStorehouses < ActiveRecord::Migration[6.0]
  def change
    create_table :storehouses do |t|
      t.string :name, comment: "名前"

      t.timestamps
    end
  end
end
