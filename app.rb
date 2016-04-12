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

get '/presentation' do
  redirect 'https://docs.google.com/presentation/d/1Gq71N-WAg1CGG62_qHmoAqbYMGkIBgdEX6y90DXkbfI'
end
