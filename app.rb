require 'sinatra/base'
require 'sinatra/reloader'
require_relative './database_connection_setup.rb'
require_relative './lib/user'

class Bnb < Sinatra::Base
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    erb :index
  end

  post '/users' do
    user = User.create(name: params['name'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect('/spaces')
  end

  get '/spaces' do
    @user = User.find(id: session[:user_id])
    erb :spaces
  end

  run! if app_file == $0
end
