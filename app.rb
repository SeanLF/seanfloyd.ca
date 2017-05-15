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

get '/presentation' do
  redirect 'https://docs.google.com/presentation/d/1Tk-oOIYUSd5ymtbCGueIWVCggXpir7n7jOVZqS5tnoE/edit?usp=sharing'
end