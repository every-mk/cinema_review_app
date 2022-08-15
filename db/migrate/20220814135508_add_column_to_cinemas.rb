class AddColumnToCinemas < ActiveRecord::Migration[6.1]
  def change
    add_column :cinemas, :end_date, :date
  end
end
