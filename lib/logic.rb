# frozen_string_literal: true

require 'byebug'
require 'open-uri'
require 'nokogiri'

class Articles
  attr_accessor :unparsed_page, :url, :parsed_page, :number_pages, :link, :all_links
  def initialize(search = 'blood', page = '1')
    @url = "https://search.scielo.org/?q=sangre&lang=en&count=15&from=1&output=site&sort=&format=summary&fb=&page=1&filter%5Bla%5D%5B%5D=en&q=#{search}&lang=en&page=#{page}"
    @page = 1
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(@unparsed_page)
    @number_pages = @parsed_page.css('div.col-md-6.notTablet.right')[0].text.split(' ')[2]
    @all_links = []
    @count = 0
    @link = @parsed_page.css('div.item')[@count].css('div.col-md-11.col-sm-10.col-xs-11')[0].css('div.line').css('a')[0].attributes['href'].value
  end

  def getting_links
    while @count <= 15
      @all_links << @link
      @count += 1
    end
    @all_links
  end

  def 
  end

end

articles = Articles.new
articles.get_links
result = articles.all_links
p result