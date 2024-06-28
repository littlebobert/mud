require 'http'
require 'json'

class OpenAIService
  def initialize(prompt)
    @prompt = prompt
  end

  def call
    api_key = ENV["OPEN_AI_API_KEY"]
    url = "https://api.openai.com/v1/chat/completions"
  
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }
  
    body = {
      model: 'gpt-4o',
      messages: [
        { "role": "user", "content": prompt }
      ],
      max_tokens: 4096
    }.to_json
  
    response = HTTP.headers(headers).post(url, body: body)
    response_data = JSON.parse(response.body.to_s)
    final = response_data["choices"].first["message"]["content"]
    return final
  end
end