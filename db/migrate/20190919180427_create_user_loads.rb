class CreateUserLoads < ActiveRecord::Migration[5.1]
  def change
    create_table :user_loads do |t|
      t.string :badge
      t.string :ssn4

      t.timestamps
    end
  end
end
