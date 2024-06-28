class ChatMessagesController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    locals = { user: current_user, content: params[:chat_message][:content],  }
    hash = { message: render_to_string(partial: "chat_message", locals: locals ) }
    PlaceChannel.broadcast_to(@place, hash)
    head :ok
  end
end
