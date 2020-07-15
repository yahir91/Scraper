# frozen_string_literal: true

require 'byebug'
require 'open-uri'
require 'nokogiri'

class Articles
  attr_accessor :unparsed_page, :url, :parsed_page, :number_pages, :link, :all_links, :title, :article_information
  def initialize(search = 'blood', page = '1')
    @url = "https://search.scielo.org/?q=sangre&lang=en&count=15&from=1&output=site&sort=&format=summary&fb=&page=1&filter%5Bla%5D%5B%5D=en&q=#{search}&lang=en&page=#{page}"
    @page = 1
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(@unparsed_page)
    @title = @parsed_page.css('div.item')[0].css('div.line.source').css('span')[2].children.text
    @number_pages = @parsed_page.css('div.col-md-6.notTablet.right')[0].text.split(' ')[2]
    @all_links = []
    @count = 0
    @link = @parsed_page.css('div.item')[@count].css('div.col-md-11.col-sm-10.col-xs-11')[0].css('div.line').css('a')[0].attributes['href'].value
    @article_information = []
  end

  def getting_links
    while @count <= 15
      @all_links << @link
      @count += 1
    end
    @all_links
  end

  def authors
    authors = []
  end

  def articles_hash
    @parsed_page.css('div.item').each do |x|
      article = {
        title: x.css('strong').text,
        authors: x.css('div.line.authors')[0].text.gsub(/\s+/, '').split(';'),
        time: x.css('div.line.source').css('span')[2].children.text + x.css('div.line.source').css('span')[1].children.text,
        link: x.css('div.col-md-11.col-sm-10.col-xs-11')[0].css('div.line').css('a')[0].attributes['href'].value
      }
      @article_information << article
    end
    @article_information
  end
end

articles = Articles.new
articles.articles_hash
result = articles.title
other = articles.article_information[0][:time]
p result
p other
