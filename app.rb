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

get '/midterm' do
  redirect 'https://docs.google.com/presentation/d/1kH1qmdP0FqlPv3sCy3QjDG_x1mU7nph1Qt4iftV_BxU/edit?usp=sharing'
end

get '/demo' do
  redirect 'https://docs.google.com/presentation/d/1YIpgIC0boEnh7EwCQHYGcSqJt1xKsU_dyHQFxFOO3so/edit?usp=sharing'
end