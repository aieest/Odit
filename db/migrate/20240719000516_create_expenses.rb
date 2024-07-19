class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :value
      t.datetime :interval
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
