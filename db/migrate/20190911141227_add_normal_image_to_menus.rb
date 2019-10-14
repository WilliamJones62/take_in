class AddNormalImageToMenus < ActiveRecord::Migration[5.1]
  def change
    add_column :menus, :normal_image, :string
  end
end
