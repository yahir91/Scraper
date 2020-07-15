# frozen_string_literal: true

require 'byebug'
require 'open-uri'
require 'nokogiri'
require_relative '../lib/logic.rb'

puts 'Type the articles you want to search'
search = gets.chomp

articles = Articles.new(search)

articles.three_pages
puts "There are #{articles.article_information.count}, Which one do you want to see?"

article_index = articles.check_article(gets.chomp.to_i)


puts articles.article_information[article_index - 1].to_a
