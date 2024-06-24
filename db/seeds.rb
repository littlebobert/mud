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
QuestLog.destroy_all
Quest.destroy_all
Item.destroy_all
Message.destroy_all
Character.destroy_all
User.all.each do |user|
	user.place = nil
  user.save!
end
Place.destroy_all

outside = Place.create!(description: "outside the front door to the Le Wagon Tokyo building", starting_zone: true)
entryway = Place.create!(description: "inside the entry way")
front_hallway = Place.create!(description: "front hallway")
all_gender_restroom = Place.create!(description: "all gender restroom")
lecture_hall = Place.create!(description: "lecture hall")
sink = Place.create!(description: "sink and trashcans")
conbini = Place.create!(description: "inside Lawson")

link1 = Link.create!(from: outside, description: "a closed door to enter", to: entryway)
link2 = Link.create!(from: entryway, to: outside, description: "a closed door to leave the building")
link3 = Link.create!(from: entryway, to: front_hallway, description: "an open door into the front hallway")
link4 = Link.create!(from: front_hallway, to: entryway, description: "an open door back into the front entryway")
link5 = Link.create!(from: front_hallway, to: all_gender_restroom, description: "a closed door to the all gender restroom")
link6 = Link.create!(from: all_gender_restroom, to: front_hallway, description: "a closed door back out into the front hallway")
link7 = Link.create!(from: front_hallway, to: lecture_hall, description: "a passthrough to the lecture hall")
link8 = Link.create!(from: lecture_hall, to: front_hallway, description: "a passthrough back into the front hallway")
link9 = Link.create!(from: lecture_hall, to: sink, description: "the sink and trash cans")
link10 = Link.create!(from: sink, to: lecture_hall, description: "back into the main lecture area")
link11 = Link.create!(from: outside, to: conbini, description: "down the street a ways to conbini")
link12 = Link.create!(from: conbini, to: outside, description: "a automatic sliding door to exit")

onigiri = Item.create!(name: "a fresh onigiri", description: "a fresh tuna mayonaise onigiri from Lawson", place: lecture_hall)

jerky = Item.create!(name: "some beef jerky", description: "some spicy beef from Lawson", place: conbini)
bar = Item.create!(name: "a protein bar", description: "a protein bar with a white wrapper and 15g of protein", place: conbini)
coffee = Item.create!(name: "a can of coffee", description: "a can of cold Boss coffee", place: conbini, replenishes: true)
kaki_pi = Item.create!(name: "a bag of kaki-pi", description: "a small bag of peanuts and crescent-shaped flavored rice crisps", place: conbini)
vegetables = Item.create!(name: "a container of vegetables and dip", description: "a small container of carrots, cucumbers, daikon radish and cabbage pieces, with dip", place: conbini)
mints = Item.create!(name: "some breath mints", description: "a blue container of Mintia (cold smash flavor)", place: conbini)
monster = Item.create!(name: "a white Monster", description: "a cold can of white Monster (Ultra)", place: conbini)

doug = Character.create!(name: "Doug", description: "Le Wagon instructor. specializes in Ruby on Rails", place: lecture_hall)

sticker = Item.create!(name: "a Le Wagon sticker", description: "a red and white sticker of the Le Wagon logo")

bring_doug_coffee = Quest.create!(name: "bring Doug coffee", description: "Doug was in a hurry to get to Le Wagon this morning and didn’t have time to grab a coffee", requirement: coffee, reward: sticker, character: doug)

puts "created #{Place.count} places, #{Link.count} links, #{Item.count} items, #{Character.count} characters, and #{Quest.count} quests"