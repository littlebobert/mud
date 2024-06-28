namespace :outdoor_activities do
  desc "Generate outdoor activities"
  task generate: :environment do
    PushOutdoorActivitiesJob.perform_later
  end
  
  desc "Generate 5pm neighborhood chime"
  task chime: :environment do
    PushAfternoonChimeJob.perform_later
  end
end
