require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/spaces'
require './lib/bookings'
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
    redirect ('/')
  end

  get '/spaces' do
    @user = User.find(id: session[:user_id])
    @spaces = Spaces.all
    #p @spaces
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
    redirect ('/')
  end
  
  get 'spaces/:spaces_id' do
    #show a calender
    #Request to book
    erb :spaces_dates
  end

  post 'spaces/:spaces_id' do
    #run the logic for posting available dates
  end

  get '/requests' do
    #requests I've made, requests I have received  
    user = User.find(id: session[:user_id])
    @accepted_bookings = Bookings.accepted_bookings(user_id: user.id)
    @requests_made = Bookings.requests_made(user_id: user.id)

    erb :requests
  end

  get '/requests/confirm' do
    #confirm requests
    erb :request_confirm
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

  get '/booking_confirmation' do
    #booking confirmation
    erb :booking_confirmation
  end

  get '/make_reservation/:id' do
    #booking confirmation    
    session[:spaces_id] = params[:id]
    @check_dates = Bookings.available_dates(spaces_id: session[:spaces_id])
    erb :make_reservation
  end

  post '/make_reservation' do
    #booking confirmation 
    p "-------#{params}------"    
    user = User.find(id: session[:user_id])    
    Bookings.do_booking(user_id: user.id, space_id: session[:spaces_id], booking_date: params[:booking_date])     
    redirect('/requests')      
  end

  post '/update_booking' do
    #update confirmation 
    p "-------#{params}------" 
    session[:bookings_id] = params[:bookings_id]   
    Bookings.update_booking(bookings_id: session[:bookings_id])     
    redirect('/requests')      
  end

  post '/delete_booking' do
    #delete booking 
    p "-------#{params}------" 
    session[:bookings_id] = params[:bookings_id]   
    Bookings.delete_booking(bookings_id: session[:bookings_id])     
    redirect('/requests')      
  end



  run! if app_file == $0
end
