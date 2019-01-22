User.create!(
  name: "Admin",
  email: "admin@framgia.com",
  password: "123456",
  password_confirmation: "123456",
  role: "admin")
Category.create!(
  name: "Sample category")
Category.create!(
  name: "Sample category 2")
Book.create!(
  title: "My first book",
  author: "Minh Phong",
  category_id: 1,
  pages_count: 50,
  publish_date: Time.zone.now
  )
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

99.times do |n|
  title  = Faker::Name.name
  Book.create!(
      title: title,
      category_id: 1,
      author: title,
      pages_count: 50,
      publish_date: Book.find(1).publish_date)
end
