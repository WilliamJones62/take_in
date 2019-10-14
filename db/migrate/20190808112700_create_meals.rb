class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :title
      t.string :collect_window
      t.integer :qty
      t.string :employee
      t.time :collected
      t.date :menu_date

      t.timestamps
    end
  end
end
