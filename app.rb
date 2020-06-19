# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/r18n'
require 'date'
require 'kramdown'
require 'active_support/core_ext/integer/inflections'
require 'builder'
require 'json'

require './helpers/date_helper'
require './helpers/translation_helper'
require './helpers/travel_post_helper'
require './helpers/cv_helper'

# Sinatra app for my personal website
class App < Sinatra::Application
  include R18n::Helpers
  register Sinatra::R18n
  set :root, __dir__

  helpers DateHelper, TravelPostHelper, CVHelper, TranslationHelper

  TRAVEL_POSTS_FOLDER = '/travel/posts/'

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

  def cv(source = "views/cv/#{R18n.get.locale.code}.cv.json")
    @json_cv = JSON.parse(File.read(source))
    @stylesheet_name = 'cv'
    @show_contact_details ||= params.include? :with_contact_details
    erb :'cv/cv'
  end

  get '/travel' do
    files = Dir["./views#{TRAVEL_POSTS_FOLDER}*"]
    @posts = []

    @posts = files.sort.reverse.map do |filename|
      content = File.open(filename, &:readlines)
      date = travel_post_date(filename)

      { title: travel_post_title(content), excerpt: travel_post_excerpt(content),
        date: date, formatted_date: format_date_mdy_ordinalize(parse_date(date)), url: travel_post_url(date) }
    end
    @stylesheet_name = 'travel'
    erb :travel
  end

  get '/travel/posts/*' do
    @stylesheet_name = 'travel_post'
    erb :travel_post, locals: { content: markdown("#{TRAVEL_POSTS_FOLDER}#{params['splat'][0]}".to_sym) }
  end

  get '/email' do
    redirect 'mailto:seanlouisfloyd@gmail.com'
  end

  get %r{(/(availability|disponibilite))} do
    redirect 'https://calendly.com/seanlf'
  end

  get '/emergency' do
    erb :emergency
  end

  get '/cv/make' do
    @stylesheet_name = 'index'
    erb :'cv/make'
  end

  post '/cv/make' do
    return redirect '/cv/make' unless params[:json_file]

    @show_contact_details = true
    @hide_change_lang = true
    cv(params[:json_file][:tempfile])
  end

  not_found do
    redirect '/404.html'
  end
end
