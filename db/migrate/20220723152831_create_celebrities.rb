class CreateCelebrities < ActiveRecord::Migration[6.1]
  def change
    create_table :celebrities do |t|
      t.string :name
      t.string :ruby
      t.date :date_of_birth
      t.string :birthplace
      t.string :history

      t.timestamps
    end
  end
end
