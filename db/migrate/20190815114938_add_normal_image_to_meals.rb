class AddNormalImageToMeals < ActiveRecord::Migration[5.1]
  def change
    add_column :meals, :normal_image, :string
  end
end
