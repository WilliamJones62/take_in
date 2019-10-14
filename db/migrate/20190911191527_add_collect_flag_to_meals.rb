class AddCollectFlagToMeals < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :collect_flag, :boolean
  end
end
