require 'sinatra/base'
require 'sinatra/reloader'

class Bnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :sessions

  get '/' do
    'Hello World'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @name = params[:name]
    p params
    redirect('/spaces')
  end

  get '/spaces' do
    erb :spaces
  end

  run! if app_file == $0
end
