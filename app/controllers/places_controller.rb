class PlacesController < ApplicationController
  skip_before_action :authenticate_user!
  
	def home
    @place = Place.where(starting_zone: true).first
    render "show"
	end
  
  def show
    @place = Place.find(params[:id])
  end
end
