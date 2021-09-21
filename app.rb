require 'sinatra/base'
require 'sinatra/reloader'
require './lib/spaces'

class Bnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello World'
  end

  get '/spaces' do
    @spaces = Spaces.all
    erb :spaces
  end

  get '/spaces/new' do
    erb :spaces_new
  end

  post '/spaces/new' do
    p "----#{params}-----"
    
    new_space = Spaces.create(
      name: params[:name],
      description: params[:description],
      price_per_night: params[:price_per_night]
    )
    redirect('/spaces')
  end

  run! if app_file == $0
end
