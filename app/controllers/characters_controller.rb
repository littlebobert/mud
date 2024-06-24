class CharactersController < ApplicationController
	def show
    @character = Character.find(params[:id])
    @messages = Message.where(character: @character, user: current_user)
    @message = Message.new
    @available_quests = @character.quests.filter { |quest| !current_user.quest_logs.map { |quest_log| quest_log.quest }.include?(quest) }
    @available_quest_infos = @available_quests.map { |quest| { quest: quest, quest_log: QuestLog.new } }
    @fullfillable_quest_logs = @character.quest_logs.filter { |quest_log| !quest_log.completed && current_user.items.include?(quest_log.quest.requirement) }
  end
end
