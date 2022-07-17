class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.integer :sex
      t.date :date_of_birth
      t.string :prefecture
      t.string :municipality
      t.text :image
      t.integer :user_id, null: false, unique: true

      t.timestamps
    end
  end
end
