# frozen_string_literal: true

require 'byebug'
require 'open-uri'
require 'nokogiri'

class Articles
  attr_accessor :unparsed_page, :url, :parsed_page, :number_pages
  def initialize(search = 'artritis', page = '1')
    @url = "https://search.scielo.org/?q=&lang=es&count=15&from=0&output=site&sort=&format=summary&fb=&page=1&q=#{search}&lang=es&page=#{page}"
    @page = 1
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(@unparsed_page)
    @number_pages = @parsed_page.css('div.col-md-6.notTablet.right')[0].text.split(' ')[2].to_i
  end
end


articles = Articles.new

result = articles.number_pages
p result
