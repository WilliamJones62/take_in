class AddDeliveredFlagToMeals < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :delivered_flag, :boolean
  end
end
