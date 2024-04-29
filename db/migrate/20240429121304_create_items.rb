class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.belongs_to :invoice, null: false, foreign_key: true
      t.text :description
      t.decimal :rate
      t.integer :quantity
      t.decimal :amount

      t.timestamps
    end
  end
end
