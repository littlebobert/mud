class PushAfternoonChimeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Place.where(outdoors: true).each do |place|
      hash = {
        outdoor_activity: "
        <div class=\"outdoor-activity\">you hear the neighborhood 17:00 chime</div>
        <div>
        <audio controls preload=\"auto\" style=\"\">
            <source src=\"/neighborhood-chime.m4a\" type=\"audio/mp4\">
        </audio>
        </div>
        ",
        activity_type: "chime"
      }
      PlaceChannel.broadcast_to(place, hash)
    end
  end
end
