class AddCollectedFlagToMeals < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :collected_flag, :boolean
  end
end
