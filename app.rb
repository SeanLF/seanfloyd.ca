require 'sinatra'

get '/' do
  @stylesheet_name = 'index'
  erb :index
end

get '/resume' do
  @stylesheet_name = 'resume'
  erb :resume
end

get '/email' do
  redirect 'mailto:sfloy029@uottawa.ca'
end
