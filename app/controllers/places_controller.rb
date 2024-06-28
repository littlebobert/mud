class PlacesController < ApplicationController
  skip_before_action :authenticate_user!
  
	def home
    @place = Place.where(starting_zone: true).first
    show_place(@place)
	end
  
  def show
    @place = Place.find(params[:id])
    show_place(@place)
  end
  
  def browse_hacker_news
    @place = Place.find(params[:place_id])
    @posts = BrowseHackerNewsService.new.call
    if current_user != nil
      current_user.activity = :browse_hacker_news.to_s
      current_user.save
    end
  end
  
  def run_ruby_code
    @place = Place.find(params[:place_id])
  end
  
  private
  
  def show_place(place)
    if place.outdoors
      @weather_report = WeatherReport.where(area: place.area).order(created_at: :desc).first
    end
    if current_user != nil
      current_user.activity = nil
      previous_place = current_user.place
      current_user.place = place
      current_user.save
      announce_departure_and_arrival(place, previous_place)
      puts "tried to save current_user. errors: #{current_user.errors != nil ? current_user.errors.full_messages : ""}"
    end
    @other_users = User.where(place: place)
    if current_user != nil
      @other_users = @other_users.where.not(email: current_user.email)
    end
    @chat_messages = []
    @chat_message = ChatMessage.new
    render "show"
  end
  
  def announce_departure_and_arrival(place, previous_place)
    return if place == previous_place
    
    # departure:
    hash = { 
      arrival_or_departure: render_to_string(partial: "arrival_or_departure", locals: { user: current_user, arrival: false } ),
      user_id: current_user.id
    }
    PlaceChannel.broadcast_to(previous_place, hash)
    # arrival:
    hash = { 
      arrival_or_departure: render_to_string(partial: "arrival_or_departure", locals: { user: current_user, arrival: true } ),
      user_id: current_user.id
    }
    PlaceChannel.broadcast_to(place, hash)
  end
end
