Gem::Specification.new do |s|
  s.name        = 'stylemooncat'
  s.version     = '0.0.12'
  s.date        = '2016-01-07'
  s.summary     = 'Scraper for StyleMoonCat'
  s.description = "This is a gem scraping StyleMoonCat's website.Input category name,page limit,searcing keyword,and price range,and it will return the items with title,price,image,and link in the page of the category"
  s.authors     = ['Even Chang',  'Luis Herrera', 'Katy Lee', 'Frank Lee']
  s.email       = ['kiki44552002@gmail.com', 'lmherrera86@gmail.com', 'katylee41024@yahoo.com.tw','frank1234211@gmail.com']
  s.files       = ["lib/stylemooncat.rb", "lib/stylemooncat/scraper.rb"]
  s.executables = ['stylemooncat']
  s.homepage    = 'http://rubygems.org/gems/stylemooncat'
  s.license       = 'MIT'
end
