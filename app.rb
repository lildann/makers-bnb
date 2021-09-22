require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
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

  get '/spaces' do
    @user = User.find(id: session[:user_id])
    erb :spaces
  end



  run! if app_file == $0
end
