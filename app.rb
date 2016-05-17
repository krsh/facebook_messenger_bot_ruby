require 'httparty'
require 'json'
require 'sinatra'
require './responder'

# https://developers.facebook.com/sa/apps/<YOUR_APP_ID>/messenger/
URL = 'https://graph.facebook.com/v2.6/me/messages?access_token=XXXXX'

get '/webhook' do
  params['hub.challenge'] if params['hub.verify_token'] == 'xxxxx'
end

post '/webhook' do
  body = request.body.read
  payload = JSON.parse(body)

  sender = payload['entry'].first['messaging'].first['sender']['id']

  message = payload['entry'].first['messaging'].first['message']
  message = message['text'] unless message.nil?

  unless message.nil?
    response = Responder.reply(message)
    HTTParty.post(URL,
                  body: { recipient: { id: sender },
                          message: { text: response } }.to_json,
                  headers: { 'Content-Type' => 'application/json' })
  end
end
