# StyleMoonCat [![Gem Version](https://badge.fury.io/rb/stylemooncat.svg)](https://badge.fury.io/rb/stylemooncat)
This is a scraper library about to scraping http://www.stylemooncat.com.tw/


## Usage

Install it with the following command:
```sh
$ gem install stylemooncat
```

Or else put it in your `Gemfile` as:
```ruby
gem stylemooncat
```

Run it from the command line. For example, to get the items in page 1 of 'top' category:
```
$ stylemooncat top 1
```

or use it from your Ruby code:
````ruby
require 'stylemooncat'
scraper = StyleMoonCat::Scraper.new
results = scraper.scrape("top",1)
````

Please see http://www.stylemooncat.com.tw/ , category can be 'allitems','newarrival','lastweek','specialdiscount','top','bottom','outer','shose','bag', or 'accessories'
