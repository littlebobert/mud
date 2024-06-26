namespace :weather do
  desc "Fetch the current weather"
  task fetch: :environment do
    FetchWeatherJob.perform_now
  end

end
