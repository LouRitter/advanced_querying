# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do 
 role = Role.create(title: Faker::Company.unique.profession, billable: [true, false].sample)
  5.times do 
    role.people.create(name: Faker::Name.unique.name, age: rand(18..60))
  end
end