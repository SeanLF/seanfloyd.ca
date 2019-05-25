require 'sinatra'

get '/' do
  @stylesheet_name = 'index'
  erb :index
end

get '/cv' do
  @stylesheet_name = 'cv'
  @show_contact_details = params[:info] == 'show'
  erb :cv
end

get '/email' do
  redirect 'mailto:seanlouisfloyd@gmail.com'
end

get '/emergency' do
  erb :emergency
end