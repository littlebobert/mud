require 'http'
require 'json'

class BrowseHackerNewsService
  def initialize
  end

  def call
    url = "https://hacker-news.firebaseio.com/v0/topstories.json"
    headers = {
      'Content-Type' => 'application/json'
    }
    response = HTTP.headers(headers).get(url)
    response_data = JSON.parse(response.body.to_s)
    first_5 = response_data.first(3)
    results = []
    first_5.each do |post_id|
      post_url = "https://hacker-news.firebaseio.com/v0/item/#{post_id}.json"
      post_response = HTTP.headers(headers).get(post_url)
      post_response_data = JSON.parse(post_response.body.to_s)
      id = post_response_data["id"]
      title = post_response_data["title"]
      url = post_response_data["url"]
      score = post_response_data["score"]
      results << { id: id, title: title, url: url, score: score }
    end
    return results
  end
end