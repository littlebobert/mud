class CharactersController < ApplicationController
	def show
    @character = Character.find(params[:id])
    @messages = Message.where(character: @character, user: current_user)
    @message = Message.new
  end
end
