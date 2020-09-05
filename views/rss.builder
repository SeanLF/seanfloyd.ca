# frozen_string_literal: true

xml.instruct!(:xml, version: '1.0')
xml.rss(version: '2.0') do
  xml.channel do
    xml.title("Sean's Travel Log")
    xml.description('Follow me (virtually) as I make my way around the Blue Marble.')
    xml.link('https://seanfloyd.ca/travel')

    @posts.each do |post|
      xml.item do
        xml.title(post[:title])
        xml.link(post[:url])
        xml.description(post[:excerpt])
        xml.pubDate(post[:date].rfc822)
        xml.guid(post[:url])
      end
    end
  end
end
