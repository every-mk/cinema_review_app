class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.boolean :want_to_see
      t.boolean :recommendation
      t.integer :after_watch
      t.boolean :spoiler
      t.string :content

      t.timestamps
    end
  end
end
