require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :datestamp, presence: true
#  validates :barber, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

before do
  @barbers = Barber.all
end  

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end



get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end


get '/' do
    @barbers = Barber.order "created_at DESC"
    erb :index
end


get '/visit' do
  erb :visit
end

post '/visit' do
  
  c = Client.new params[:client]
  c.save

#  @username = params[:username]
#  @phone = params[:phone]
#  @datetime = params[:datetime]
#  @barber = params[:barber]
#  @color = params[:color]

#  c = Client.new
#  c.name = @username 
#  c.phone =  @phone
#  c.datestamp = @datetime
#  c.barber = @barber
#  c.color = @color
#  c.save
  if c.save
    erb "<h2>Спасибо, что записались </h2>"
  else
    erb "<h2>Ошибка! Введите данные</h2>"
  end  
        
end