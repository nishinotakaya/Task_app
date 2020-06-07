# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password")
              
  60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end            

@users = User.order(:created_at).take(3)
50.times do |t|
  task_name = Faker::Lorem.sentence
  task_description = Faker::Lorem.sentence
  @users.each{ |user| user.tasks.create!(name: task_name, description: task_description) }
end