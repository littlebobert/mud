class ChatMessagesController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    @chat_message = ChatMessage.new(message_params)
    @chat_message.place = @place
    @chat_message.user = current_user
    if @chat_message.save
      PlaceChannel.broadcast_to(
        @place,
        render_to_string(partial: "chat_message", locals: { chat_message: @chat_message} )
      )
      head :ok
    else
      render "places/show", status: :unprocessable_entity
    end
  end
  
  private
  
  def message_params
    params.require(:chat_message).permit(:content)
  end
end
