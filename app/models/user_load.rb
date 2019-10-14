class UserLoad < ApplicationRecord
  self.table_name = "menu_user_loads"
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      UserLoad.create! row.to_hash
    end
  end

  def self.load_users
    all.each do |p|
      if !p.badge.blank? && !p.ssn4.blank?
        # good user data create a user
        u = User.new
        u.email = p.badge
        u.password = p.ssn4
        u.save
      end
    end
  end

end
