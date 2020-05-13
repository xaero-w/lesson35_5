require 'nokogiri'
require 'open-uri'
require_relative 'lib/filmreader'

# URL = "https://www.kinopoisk.ru/lists/top250/?is-redirected=1".freeze
URL = "https://www.kinoafisha.info/rating/movies/2019/"

html = open(URL) { |result| result.read }
doc = Nokogiri::HTML(html)

film_list = []
doc.css('.films_name').each do |row|
  film = row.text.chomp
  film_list << film
end

directors = []
doc.css('.films_info_link').map do |row|
  director = row.text.chomp
  directors << director
end

contents = Hash[film_list.zip directors]

film_contents = []
contents.map do |key, value|
  film_contents << [key, value]
end

film_info = []

film_contents.map do |title, director|
  film_info << Filmreader.new(title, director)
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
