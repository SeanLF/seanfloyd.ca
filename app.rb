require 'sinatra'
require 'sinatra/r18n'
require 'date'
require 'kramdown'
require 'active_support/core_ext/integer/inflections'
require 'builder'
require 'json'
include R18n::Helpers

require './helpers/date_helper'
require './helpers/travel_helper'
require './helpers/cv_helper'

helpers DateHelper, TravelHelper, CVHelper

TRAVEL_POSTS_FOLDER = '/travel/posts'

get '/' do
  @stylesheet_name = 'index'
  erb :index
end

get '/cv' do
  return redirect cv_paths['fr'] if R18n.get.locale.code.include? 'fr'

  cv
end

get '/:locale/cv' do
  cv
end

def cv
  @json_cv = JSON.parse(File.read("views/cv/#{R18n.get.locale.code}.cv.json"))
  @stylesheet_name = 'cv'
  @show_contact_details = !params[:with_contact_details].nil?
  erb :'cv/cv'
end

get '/travel' do
  @posts = read_posts
  @stylesheet_name = 'travel'
  erb :travel
end

get '/travel/posts/*' do
  @stylesheet_name = 'travel_post'
  erb :travel_post, locals: { content: markdown("#{TRAVEL_POSTS_FOLDER}/#{params['splat'][0]}".to_sym) }
end

get '/travel.rss' do
  @posts = read_posts
  builder :rss
end

get '/email' do
  redirect 'mailto:seanlouisfloyd@gmail.com'
end

get '/emergency' do
  erb :emergency
end

get '/cv/make' do
  @stylesheet_name = 'index'
  erb :'cv/make'
end

post '/cv/make' do
  redirect_to '/cv/make' unless params[:json_file]

  @json_cv = JSON.parse(File.read(params[:json_file][:tempfile]))
  @stylesheet_name = 'cv'
  @show_contact_details = true
  erb :'cv/cv'
end
