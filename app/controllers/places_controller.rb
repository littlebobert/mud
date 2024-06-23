class PlacesController < ApplicationController
  skip_before_action :authenticate_user!
  
	def home
    @place = Place.where(starting_zone: true).first
    render "show"
	end
  
  def show
    @place = Place.find(params[:id])
    if current_user
      current_user.place = @place
      current_user.save
    end
    @other_users = User.where(place: @place)
    if current_user != nil
      @other_users = @other_users.where.not(email: current_user.email)
    end
  end
end
