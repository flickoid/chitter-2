require 'sinatra'
require 'data_mapper'
require './lib/peep'
require './lib/user'
require_relative 'helpers/app_helper'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'

get '/' do
  @peeps = Peep.all
  erb :index
end

post '/peeps' do
  content = params["content"]
  Peep.create(:content => content)
  redirect to('/')
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.create(:name => params[:name], :username => params[:username], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
  session[:user_id] = user.id
  redirect to('/')
end