require 'sinatra/base'
require 'sinatra/reloader'

class Bnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  post '/login' do
    erb :('')
  end

  run! if app_file == $0
end
