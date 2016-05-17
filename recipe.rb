require 'httparty'
require 'json'

# Food2Fork module
module Food2Fork
  KEY = 'xxxxx'
  BASE_URL = "http://food2fork.com/api/search?key=#{KEY}&q="

  def self.recipe(message)
    response = HTTParty.get(BASE_URL + message)
    resp_hash = JSON.parse(response)

    if resp_hash['count'] > 0
      no = rand(resp_hash['count'])
      message = resp_hash['recipes'][no]['title'] + ' - ' + resp_hash['recipes'][no]['f2f_url']
      message
    else
      'Sorry no recipes...'
    end
  end
end
