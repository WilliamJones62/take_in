class Menu < ApplicationRecord
  validates :menu_date, presence: true
  validates :title, presence: true
  validates :qty, presence: true
end
