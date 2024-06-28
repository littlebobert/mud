class PushAfternoonChimeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Place.where(outdoors: true).each do |place|
      hash = {
        outdoor_activity: "<div class=\"outdoor-activity\">you hear the neighborhood 17:00 chime</div>"
      }
      PlaceChannel.broadcast_to(place, hash)
    end
  end
end
