class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.boolean :recommendation
      t.integer :after_watch
      t.boolean :spoiler
      t.string :content
      t.integer :user_id, null: false, unique: true
      t.integer :cinema_id, null: false, unique: true

      t.timestamps
    end
  end
end
