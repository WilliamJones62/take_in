task :user_loads => :environment do
  UserLoad.load_users
end
