# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
5.times do 
  region = Region.create(name: Faker::Address.unique.country)
  region.locations.create(name: Faker::Address.unique.city)
end
manager_role = Role.create(title: "Manager", billable: [true, false].sample)
manager_1 = Person.create(name: Faker::Name.unique.name, role_id: manager_role.id,  age: rand(18..60),  salary: rand(30000..120000), location_id: Location.all.map(&:id).sample)
manager_2 = Person.create(name: Faker::Name.unique.name, role_id: manager_role.id,  age: rand(18..60), salary: rand(30000..120000), location_id: Location.all.map(&:id).sample)

if manager_1.save && manager_2.save 
  5.times do 

  role = Role.create(title: Faker::Company.profession, billable: [true, false].sample)
    5.times do 
      role.people.create(name: Faker::Name.unique.name, age: rand(18..60), salary: rand(30000..120000), manager_id: [manager_1.id, manager_2.id].sample, location_id: Location.all.map(&:id).sample)
    end
  end
end

