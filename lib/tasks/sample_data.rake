namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do


    99.times do |n|
      username  = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end


    users = User.all
    60.times do
      name = Faker::Name.last_name
      keycode = Faker::Name.last_name
      users.each { |user| user.playlists.create!(name: name,
                                                 keycode: keycode) }
    end


  end
end
