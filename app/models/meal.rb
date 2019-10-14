class Meal < ApplicationRecord
  validates :employee, presence: true
  validates :collect_window, presence: true
  validates :qty, presence: true
  validates :title, presence: true

end
