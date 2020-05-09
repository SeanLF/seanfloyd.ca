require 'sinatra'
require 'date'
require 'kramdown'
require 'active_support/core_ext/integer/inflections'
require 'builder'
require 'json'

TRAVEL_POSTS_FOLDER = '/travel/posts'

get '/' do
  @stylesheet_name = 'index'
  erb :index
end

get '/cv' do
  @json_cv = JSON.parse(File.read('views/cv/resume.json'))
  @stylesheet_name = 'cv'
  @show_contact_details = !params[:with_contact_details].nil?
  erb :'cv/cv'
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

def format_date_my(date)
  date = Date.parse(date)
  date.strftime("%b %Y")
end

def how_long(start_date, end_date)
  distance_in_days = (Date.parse(end_date) - Date.parse(start_date)).to_f
  how_long_in_words(distance_in_days)
end

# x month(s) OR x year(s) OR x year(s), x month(s)
def how_long_in_words(distance_in_days)
  _DAYS_IN_YEAR = 365
  distance_in_months = distance_in_months(distance_in_days)
  if distance_in_months < 1
    ''
  elsif (distance_in_months < 12)
    naive_pluralize('month', distance_in_months)
  else
    years = (distance_in_days / _DAYS_IN_YEAR).round
    distance_in_days -= years * _DAYS_IN_YEAR
    length = naive_pluralize('year', years)
    months = how_long_in_words(distance_in_months)
    if months.empty?
      return length
    end
    length << ', ' << months
  end
end

def distance_in_months(distance_in_days)
  _DAYS_IN_MONTH = 30
  (distance_in_days / _DAYS_IN_MONTH).round
end

def naive_pluralize(word, count)
  word = count === 1 ? word : word << 's'
  "#{count} #{word}"
end

def format_date_mdy_ordinalize(date)
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
      unless line.to_s.gsub(/^===/, "").strip.empty?
        excerpt = line[0, 100].strip + '...'
        break
      end
    end
    
    post = {title: title, excerpt: excerpt, date: date, formatted_date: format_date_mdy_ordinalize(date), url: travel_post_url(date)}
    @posts << post
  end

  return @posts
end
