class AddEmployeeStatusToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :Employee_Status, :string
  end
end
