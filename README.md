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

The result of format is like:
````
{:title=>"立領坑條細織背心*9色", :price=>"280", :images=>"/photo/01080327/01080327.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24125-dn"}
{:title=>"羅紋立領合身毛衣*4色", :price=>"330", :images=>"/photo/01110084/01110084.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"}
{:title=>"尖頭壓紋平底跟鞋*2色", :price=>"540", :images=>"/photo/09070006/09070006.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24732"}
````
