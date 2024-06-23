require_relative '../services/dialog_service'

class MessagesController < ApplicationController
  def create
    @character = Character.find(params[:character_id])
    @message = Message.new(message_params.merge(character: @character, user: current_user, from_user: true))
    if @message.save
      chat_history = Message.where(character: @character).map do |message|
        "#{message.created_at.strftime("%b %e, %l:%M %p")}: #{message.content}"
      end
      response = DialogService.new(@character.name, @character.description, chat_history).call
      @response = Message.new(message_params.merge(character: @character, user: current_user, content: response, from_user: false))
      if @response.save
        redirect_to character_path(@character)
      else
        render "character/show", status: :unprocessable_entity  
      end
    else
      render "character/show", status: :unprocessable_entity
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end
