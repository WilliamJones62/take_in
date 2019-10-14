class CreateRecipeImages < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_images do |t|
      t.integer :recipe_id
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
