require 'sinatra'
require 'date'
require 'kramdown'
require 'active_support/core_ext/integer/inflections'
require 'builder'

TRAVEL_POSTS_FOLDER = '/travel/posts'

get '/' do
  @stylesheet_name = 'index'
  erb :index
end

get '/cv' do
  @stylesheet_name = 'cv'
  @show_contact_details = params[:info] == 'show'
  erb :cv
end

get '/travel' do
  @posts = generate_posts
  @stylesheet_name = 'travel'
  erb :travel
end

get '/travel/posts/*' do
  @stylesheet_name = 'travel_post'
  erb :travel_post, :locals => { :content => markdown("#{TRAVEL_POSTS_FOLDER}/#{params['splat'][0]}".to_sym) }
end

get '/travel.rss' do
  @posts = generate_posts
  builder :rss
end

get '/email' do
  redirect 'mailto:seanlouisfloyd@gmail.com'
end

get '/emergency' do
  erb :emergency
end

private
def travel_post_url(date)
  "/travel/posts/#{format_date_ymd(date)}"
end

def format_date_ymd(date)
  date.strftime('%Y-%m-%d')
end

def format_date_md_ordinalize(date)
  date.strftime("%B #{date.day.ordinalize}, %Y")
end

def get_date_from_file(file)
  /(\d{4}-\d{2}-\d{2})/.match(file)[1]
end

def generate_posts
  files = Dir["./views/#{TRAVEL_POSTS_FOLDER}/*"]
  @posts = []

  for file in files.sort.reverse
    content = File.open(file, &:readlines)
    title = content[0].delete_prefix("# ").strip
    date = Date.parse(get_date_from_file(file))
    for line in content.drop(1)
      unless line.to_s.strip.empty?
        excerpt = line[0, 100].strip + '...'
        break
      end
    end
    
    post = {title: title, excerpt: excerpt, date: date, formatted_date: format_date_md_ordinalize(date), url: travel_post_url(date)}
    @posts << post
  end

  return @posts
end