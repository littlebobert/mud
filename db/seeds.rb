# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Link.destroy_all
Item.destroy_all
Message.destroy_all
Character.destroy_all
Place.destroy_all

outside = Place.new(description: "outside the front door to the Le Wagon Tokyo building", starting_zone: true)
entryway = Place.new(description: "inside the entry way")
front_hallway = Place.new(description: "front hallway")
all_gender_restroom = Place.new(description: "all gender restroom")
lecture_hall = Place.new(description: "lecture hall")
sink = Place.new(description: "sink and trashcans")

link1 = Link.new(from: outside, description: "a locked door", to: entryway)
link2 = Link.new(from: entryway, to: outside, description: "a closed door to leave the building")
link3 = Link.new(from: entryway, to: front_hallway, description: "an open door into the front hallway")
link4 = Link.new(from: front_hallway, to: entryway, description: "an open door back into the front entryway")
link5 = Link.new(from: front_hallway, to: all_gender_restroom, description: "a closed door to the all gender restroom")
link6 = Link.new(from: all_gender_restroom, to: front_hallway, description: "a closed door back out into the front hallway")
link7 = Link.new(from: front_hallway, to: lecture_hall, description: "a passthrough to the lecture hall")
link8 = Link.new(from: lecture_hall, to: front_hallway, description: "a passthrough back into the front hallway")
link9 = Link.new(from: lecture_hall, to: sink, description: "the sink and trash cans")
link10 = Link.new(from: sink, to: lecture_hall, description: "back into the main lecture area")

outside.save!
entryway.save!
front_hallway.save!
all_gender_restroom.save!
lecture_hall.save!
sink.save!

link1.save!
link2.save!
link3.save!
link4.save!
link5.save!
link6.save!
link7.save!
link8.save!
link9.save!
link10.save!

onigiri = Item.new(name: "an onigiri", description: "a fresh tuna mayonaise onigiri from Lawson", place: lecture_hall)

onigiri.save!

doug = Character.new(name: "Doug", description: "Le Wagon instructor. specializes in Ruby on Rails", place: lecture_hall)

doug.save!

puts "created #{Place.count} places, #{Link.count} links, #{Item.count} items, and #{Character.count} characters"