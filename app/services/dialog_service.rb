require 'http'
require 'json'

class DialogService
  def initialize(npc_name, npc_description, only_speaks_japanese, item, quests, conversation_history)
    @npc_name = npc_name
    @npc_description = npc_description
    @only_speaks_japanese = only_speaks_japanese
    @item = item
    @quests = quests
    @conversation_history = conversation_history
  end

  def call
	  api_key = ENV["OPEN_AI_API_KEY"]
	  url = "https://api.openai.com/v1/chat/completions"
	
  	headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
  	}
	
    quest_descriptions = @quests.map do |quest|
      "#{quest.name}: #{quest.description}"
    end
    
    # quests_prompt = quest_descriptions.count > 0 ? "In their first message and only in their first message, casually mention the following quests: #{quest_descriptions}" : ""
    
    quests_prompt = ""
    
    japanese_language_request = @only_speaks_japanese ? "Please only respond in Japanese, not English. And act as if you don’t speak or understand English." : ""
    
    item_prompt = @item != nil ? "If the user asks for #{@item.name} and describes it (#{@item.description}), please respond with \"Here it is\", or \"はい、これ\"." : ""
  
  	prompt = "We are building a text based RPG about a coding bootcamp. Please respond to the user as if you were an NPC with the following name: #{@npc_name} and description: #{@npc_description}. Please respond in the way that a human would respond verbally. Please just respond with the content, don’t include the NPC name. #{japanese_language_request} #{quests_prompt} #{item_prompt} Here is the conversation history so far: #{@conversation_history}"
	
  	body = {
		  model: 'gpt-4o',
		  messages: [
        { "role": "user", "content": prompt }
		  ],
		  max_tokens: 4096
  	}.to_json
	
  	response = HTTP.headers(headers).post(url, body: body)
  	response_data = JSON.parse(response.body.to_s)
    puts response_data
  	final = response_data["choices"].first["message"]["content"]
  	return final
  end
end