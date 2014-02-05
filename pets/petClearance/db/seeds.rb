# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pets.delete_all

Pets.create!(
  type:'dog',
  name:'foofy',
  breed:'black lab',
  description:%{<p>A big ole, run of the lug, cheesy chasey cheeseburger chugger.</p>},
  image_url:'American-Eskimo-dog.jpg'
)

Pets.create!(
  type:'dog',
  name:'poofy',
  breed:'brown lab',
  description:%{<p>A big ole, run of the lug, dicey kitey micey mincer.</p>},
  image_url:'cute-dog.jpg'
)

Pets.create!(
  type:'dog',
  name:'loofy',
  breed:'teal lab',
  description:%{<p>A big ole, run of the lug, chooby poogy derby rerby.</p>},
  image_url:'Dog-Computer-Wallpaper.jpg'
)
