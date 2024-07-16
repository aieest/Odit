class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :given_name
      t.string :last_name
      t.string :gender
      t.string :profile_picture
      t.decimal :balance
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
