require_relative '../lib/stylemooncat.rb'

@scraper = StyleMoonCat::Scraper.new

puts ARGV
puts @scraper.get_top(ARGV[0])
