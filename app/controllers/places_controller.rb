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
      current_user.activity = :browsing_hacker_news.to_s
      current_user.save
    end
  end
  
  private
  
  def show_place(place)
    if current_user != nil
      current_user.activity = nil
      current_user.place = place
      current_user.save
      puts "tried to save current_user. errors: #{current_user.errors != nil ? current_user.errors.full_messages : ""}"
    end
    @other_users = User.where(place: place)
    if current_user != nil
      @other_users = @other_users.where.not(email: current_user.email)
    end
    render "show"
  end
end
