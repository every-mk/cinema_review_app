class CreateCinemas < ActiveRecord::Migration[6.1]
  def change
    create_table :cinemas do |t|
      t.string :title
      t.time :screen_time
      t.string :birthplace
      t.string :movie_rating
      t.string :director
      t.string :original
      t.string :appearance
      t.string :screenwriter
      t.string :distribution
      t.date :start_date
      t.string :story

      t.timestamps
    end

    add_index :cinemas, :title, unique: true
  end
end
