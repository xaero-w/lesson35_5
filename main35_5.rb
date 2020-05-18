require 'nokogiri'
require 'open-uri'
require_relative 'lib/film'

# URL = "https://www.kinopoisk.ru/lists/top250/?is-redirected=1".freeze
URL = "https://www.kinoafisha.info/rating/movies/2019/"

html = open(URL) { |result| result.read }
doc = Nokogiri::HTML(html)

film_list = doc.css(".films_name").map { |row| row.text.chomp}
directors = doc.css(".films_info_link").map { |row| row.text.chomp}

film_info = Hash[film_list.zip directors].map do |title, director|
  Film.new(title, director)
end

film_to_choose = film_info.sample(6)

puts
puts "Программа «Фильм на вечер»"

film_to_choose.each.with_index(1) do |element, index|
  puts "#{index}. #{element.director}"
end

puts
puts "Фильм какого режиссера вы хотите сегодня посмотреть?"
user_choice = STDIN.gets.to_i

puts
puts "И сегодня вечером рекомендую посмотреть:"
puts film_to_choose[user_choice - 1]
