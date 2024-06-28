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
Message.destroy_all
Character.destroy_all
Item.destroy_all
User.all.each do |user|
	user.place = nil
  user.save!
end
ChatMessage.destroy_all
Place.destroy_all
WeatherReport.destroy_all

outside = Place.create!(description: "outside the front door to the Le Wagon Tokyo building", starting_zone: true, outdoors: true)
entryway = Place.create!(description: "inside the entry way")
front_hallway = Place.create!(description: "front hallway")
all_gender_restroom = Place.create!(description: "all gender restroom")
lecture_hall = Place.create!(description: "lecture hall")
sink = Place.create!(description: "sink and trashcans")
conbini = Place.create!(description: "inside Lawson")
meguro_dori = Place.create!(description: "on Meguro-dori, outside the police box", outdoors: true)
police_box = Place.create!(description: "inside the Shimomeguro police box")

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
link13 = Link.create!(from: outside, to: meguro_dori, description: "down the side street towards Meguro-dori")
link14 = Link.create!(from: meguro_dori, to: police_box, description: "a door into the police box")
link15 = Link.create!(from: police_box, to: meguro_dori, description: "out the door onto Meguro-dori")
link16 = Link.create!(from: meguro_dori, to: outside, description: "back towards Le Wagon")

onigiri = Item.create!(name: "a fresh onigiri", description: "a fresh tuna mayonaise onigiri from Lawson", place: lecture_hall)

jerky = Item.create!(name: "some beef jerky", description: "some spicy beef from Lawson", place: conbini)
bar = Item.create!(name: "a protein bar", description: "a protein bar with a white wrapper and 15g of protein", place: conbini)
coffee = Item.create!(name: "a can of coffee", description: "a can of cold Boss coffee", place: conbini, replenishes: true)
kaki_pi = Item.create!(name: "a bag of kaki-pi", description: "a small bag of peanuts and crescent-shaped flavored rice crisps", place: conbini)
vegetables = Item.create!(name: "a container of vegetables and dip", description: "a small container of carrots, cucumbers, daikon radish and cabbage pieces, with dip", place: conbini)
mints = Item.create!(name: "some breath mints", description: "a blue container of Mintia (cold smash flavor)", place: conbini)
monster = Item.create!(name: "a white Monster", description: "a cold can of white Monster (Ultra)", place: conbini)
macbook = Item.create!(name: "a MacBook Pro", description: "a black 14-inch MacBook Pro with a red and white Le Wagon sticker on the back")
ichiman_yen = Item.create!(name: "an ichi-man yen", description: "a crisp 10,000 yen note")

doug = Character.create!(name: "Doug", description: "Le Wagon instructor. specializes in Ruby on Rails", place: lecture_hall)

police_man = Character.create!(name: "a police man", description: "a Tokyo police officer", place: police_box, only_speaks_japanese: true, item: macbook)

sticker = Item.create!(name: "a Le Wagon sticker", description: "a red and white sticker of the Le Wagon logo")

bring_doug_coffee = Quest.create!(name: "bring Doug coffee", description: "Doug was in a hurry to get to Le Wagon this morning and didn’t have time to grab a coffee", requirement: coffee, reward: sticker, character: doug)

find_lost_macbook = Quest.create!(name: "find Doug’s lost MacBook", description: "Doug lost his MacBook. it was a black 14-inch MacBook Pro with a red and white Le Wagon sticker on the back", requirement: macbook, reward: ichiman_yen, character: doug, one_shot: true)

FetchWeatherJob.perform_now

puts "created #{Place.count} places, #{Link.count} links, #{Item.count} items, #{Character.count} characters, #{Quest.count} quests, and #{WeatherReport.count} weather reports"