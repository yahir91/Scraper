require 'byebug'
require 'open-uri'
require 'nokogiri'
require_relative '../lib/article_processor.rb'

puts 'Type the articles you want to search'
search = gets.chomp

articles = ArticlesProcessor.new(search)

articles.articles_info
array = []
count = 1
articles.article_information.each do |x|
    array << "#{count} #{x[:title=]}"
    count += 1
end

puts array

puts "There are #{articles.article_information.count} articles, Which one do you want to see?"

article_index = articles.check_article(gets.chomp.to_i)

puts articles.article_information[article_index - 1].to_a
