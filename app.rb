require 'sinatra/base'
require 'sinatra/reloader'

class Bnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    #save the login information
    redirect('/spaces')
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    @name = params[:name]
    #instance variable not interpolating to spaces.erb view
    p params
    redirect('/spaces')
  end

  get '/spaces' do
    @name = session[:name]
    erb :spaces
  end

  run! if app_file == $0
end
