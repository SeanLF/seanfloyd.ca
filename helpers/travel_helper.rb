module TravelHelper
  def travel_post_url(date)
    "/travel/posts/#{format_date_ymd(date)}"
  end
  
  def get_date_from_file(file)
    /(\d{4}-\d{2}-\d{2})/.match(file)[1]
  end
  
  def read_posts
    files = Dir["./views/#{TRAVEL_POSTS_FOLDER}/*"]
    @posts = []
  
    for file in files.sort.reverse
      content = File.open(file, &:readlines)
      title = content[0].delete_prefix("# ").strip
      date = Date.parse(self.get_date_from_file(file))
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
end