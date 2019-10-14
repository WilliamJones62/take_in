class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :Lastname
      t.string :Firstname
      t.string :Cost_Center_Code
      t.string :image
      t.string :Badge_No
      t.string :Badge_

      t.timestamps
    end
  end
end
