class Employee < ApplicationRecord
  establish_connection "production".to_sym

  def name
    "#{self.Firstname} #{self.Lastname}"
  end

end
