require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/spaces'
require_relative './lib/user'

class Bnb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  post '/users/new' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect('/spaces')
  end

  get '/login' do
    erb :login
  end

  post '/users/session' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/spaces')
    else
      flash[:notice] = 'Incorrect email or password'
      redirect('/login')
    end
  end 

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You are signed out'
    redirect ('/login')
  end

  get '/spaces' do
    @user = User.find(id: session[:user_id])
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
    if params[:name].nil? 
      flash[:notice] = 'Please enter details' 
    end
    redirect('/spaces')
  end

  run! if app_file == $0
end
