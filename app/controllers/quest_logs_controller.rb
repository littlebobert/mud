class QuestLogsController < ApplicationController
  def create
    quest = Quest.find(params[:quest_id])
    quest_log = QuestLog.new(quest_log_params.merge(quest: quest, user: current_user))
    if quest_log.save
      redirect_to character_path(quest.character), notice: "you just embarked on a new quest: #{quest.name}"
    else
      render "character/show", status: :unprocessable_entity
    end
  end
  
  def update
    quest_log = QuestLog.find(params[:id])
    requirement = quest_log.quest.requirement
    if current_user.items.include?(requirement)
      quest_log.completed = true
      reward = quest_log.quest.reward
      current_user.items.delete(requirement)
      current_user.items << reward
      if quest_log.save && current_user.save
        redirect_to character_path(quest_log.quest.character), notice: "congrats! here’s #{reward.name}"
      else
        redirect_to character_path(quest_log.quest.character), notice: "an error occurred. please contact support"
      end
    else
      render "character/show", status: :unprocessable_entity
    end
  end
  
  private
  
  def quest_log_params
    params.permit()
  end
end
