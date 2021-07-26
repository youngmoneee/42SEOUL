#!/usr/bin/ruby -w

require 'nokogiri'
require 'open-uri'



class Ft_wikipedia
  
  @@wiki = "http://en.wikipedia.org/"
  @@log = []

  def self.search keyword
    unless keyword.include? "wiki/"
      keyword = "wiki/" + keyword
      puts "First search @ :#{@@wiki}#{keyword}"
    end
    doc = Nokogiri::HTML(open"#{@@wiki}#{keyword}")
    new = doc.css('p > a')
    puts "#{new[0]['href']} : #{new[0].class}"
    
    if @@log.include? keyword
      Loop detected there is no way to philosophy here
      return nil;
    end
    @@log.push keyword

    puts keyword
  end

end

Ft_wikipedia.search("kiss")
