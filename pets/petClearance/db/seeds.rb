# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.delete_all

Pet.create!(
  petType: 'dog',
  name: 'foofy',
  breed: 'black lab',
  description: %{<p>A big ole, run of the lug, cheesy chasey cheeseburger chugger.</p>},
  image_url: 'American-Eskimo-dog.jpg'
)

Pet.create!(
  petType: 'dog',
  name: 'poofy',
  breed: 'brown lab',
  description: %{<p>A big ole, run of the lug, dicey kitey micey mincer.</p>},
  image_url: 'cute-dog.jpg'
)

Pet.create!(
  petType: 'dog',
  name: 'loofy',
  breed: 'teal lab',
  description: %{<p>A big ole, run of the lug, chooby poogy derby rerby.</p>},
  image_url: 'Dog-Computer-Wallpaper.jpg'
)
