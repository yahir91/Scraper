# frozen_string_literal: true

require 'byebug'
require 'open-uri'
require 'nokogiri'

class Articles
  attr_accessor :unparsed_page, :url, :parsed_page, :number_pages, :link, :all_links, :title, :article_information, :page
  def initialize(search = 'blood', number_pages = 3)
    @page = 1
    @url = "https://search.scielo.org/?q=sangre&lang=en&count=15&from=#{@from}&output=site&sort=&format=summary&fb=&page=#{@page}&filter%5Bla%5D%5B%5D=en&q=#{search}&lang=en"
    @search = search
    @from = 1
    @unparsed_page = URI.open(@url)
    @parsed_page = Nokogiri::HTML(@unparsed_page)
    @title = @parsed_page.css('div.item')[0].css('div.line.source').css('span')[2].children.text
    @article_information = []
    @number_pages = number_pages
  end

  def url_change
    @page += 1
    @from += 15
    @url = "https://search.scielo.org/?q=sangre&lang=en&count=15&from=#{@from}&output=site&sort=&format=summary&fb=&page=#{@page}&filter%5Bla%5D%5B%5D=en&q=#{@search}&lang=en"
  end

  def articles_hash(parsed_page)
    parsed_page.css('div.item').each do |x|
      article = {
        title: x.css('strong').text,
        authors: x.css('div.line.authors')[0].text.gsub(/\s+/, '').split(';'),
        time: x.css('div.line.source').css('span')[2].children.text + x.css('div.line.source').css('span')[1].children.text,
        link: x.css('div.col-md-11.col-sm-10.col-xs-11')[0].css('div.line').css('a')[0].attributes['href'].value
      }
      @article_information << article
    end
  end

  def three_pages
    while @page <= @number_pages
      unparsed_page = URI.open(@url)
      @parsed_page = Nokogiri::HTML(unparsed_page)
      articles_hash(@parsed_page)
      url_change()
      puts @url
    end
    @article_information
  end
end

articles = Articles.new
articles.three_pages

result = articles.title
other = articles.article_information[40]
puts articles.page
puts other
puts articles.url
