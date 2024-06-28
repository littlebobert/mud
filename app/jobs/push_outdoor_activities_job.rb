class PushOutdoorActivitiesJob < ApplicationJob
  queue_as :default
  
  ACTIVITY_DESCRIPTIONS = [
    "a taxi goes by",
    "a man rides by on a bicycle",
    "a small group of school children led by a few women go by",
    "a small white van drives by",
    "a young couple walks by",
    "a woman rides by on a mamachari",
    "a group of men in suits walk by",
    "a woman pops her head out of a nearby shop, looks at you, then goes back inside",
    "you hear a man on a megaphone nearby",
    "a construction worker walks by, saying something into a walkie-talkie",
    "a bird lands in front of you, then immediately takes off in the opposite direction"
  ]

  def perform(*args)
    time = Time.now.in_time_zone("Tokyo")
    return unless 7 <= time.hour && time.hour <= 18

    Place.where(outdoors: true).each do |place|
      random_activity = ACTIVITY_DESCRIPTIONS.sample
      hash = { 
        outdoor_activity: "<div class=\"outdoor-activity\">#{random_activity}</div>"
      }
      PlaceChannel.broadcast_to(place, hash)
    end
  end
end
