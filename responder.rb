require './recipe'

# Responder module
module Responder
  def self.reply(message)
    command = message.downcase.split(' ')

    response = case command[0]
               when 'info' then 'More info at http://example.org'
               when 'help' then 'recipe ingredients (Ingredients should be separated by spaces).'
               when 'recipe' then ::Food2Fork.recipe(command[1..-1].join(','))
               else 'Unknown...'
               end

    response
  end
end
