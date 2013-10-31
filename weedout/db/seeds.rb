# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# to use run 'rake db:seed'
5.times do |i|
  Course.create(course_title: "Course Title ##{i}", description: "A really great unique course description", call_number: i)
end
