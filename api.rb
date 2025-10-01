# api.rb

require 'sinatra'
require 'sinatra/cross_origin' # Gem for handling web browser security
require 'json'
require 'TechWriter_gem' # Your actual gem

# Configure Cross-Origin Resource Sharing (CORS)
# This is crucial to allow your website to talk to your API
configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

# Define a POST endpoint because the website will be sending data (a prompt)
post '/ask_gemini' do
  # Get the JSON data sent from the website
  request_payload = JSON.parse(request.body.read)
  prompt = request_payload['prompt']

  # Return an error if the prompt is missing
  return { error: 'Prompt is missing' }.to_json if prompt.nil?

  # Use your gem to get a response from the Google Gemini API
  # The method name 'ask' is just an example
  gemini_response = TechWriter.ask(prompt)

  # Send the response back to the website as JSON
  content_type :json
  { response: gemini_response }.to_json
end
