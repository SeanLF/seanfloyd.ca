# frozen_string_literal: true

# Module to parse travel posts
module TravelPostHelper
  def travel_post_title(content)
    content[0].delete_prefix('#').strip
  end

  def travel_post_excerpt(content)
    content.drop(1).each do |line|
      return line[0, 100].strip + '...' unless line.to_s.gsub(/^===/, '').strip.empty?
    end
    nil
  end

  def travel_post_date(filename)
    /(\d{4}-\d{2}-\d{2})/.match(filename)[1]
  end

  def travel_post_url(date)
    "/travel/posts/#{date}"
  end
end
