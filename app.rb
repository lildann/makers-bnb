require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user'

class Bnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  enable :sessions

  get '/' do
    erb :index
  end

  post '/users' do
    User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect('/spaces')
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    redirect('/spaces')
  end

  get '/spaces' do
    @user = User.find(session[:user_id])
    erb :spaces
  end

  run! if app_file == $0
end
