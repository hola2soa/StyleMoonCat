# StyleMoonCat [![Gem Version](https://badge.fury.io/rb/stylemooncat.svg)](https://badge.fury.io/rb/stylemooncat)
This is a scraper library about to scraping http://www.stylemooncat.com.tw/

StyleMoonCat is an ecommerce website selling women clothing but does not have a public api.
This API allows the scrapping of the site to extract the title ,price,images,link of product webpage , of items sold.

Note that StyleMoonCat does not have a robots.txt. checked on(Dec 10, 2015)

## Usage

Install stylemooncat api using this command:
```sh
$ gem install stylemooncat
```

The first parameter represents the category you want to scrape. If no parameters
are passed then the "latest" category is scrapped.
The second parameter can be an integer to represent max number of pages
to scrape or it can be a string representing item title to filter. The third and
fourth parameter can be used to represent price range. Leaving the page limit to be
represented by the firth parameter. For example:

```sh
$ stylemooncat tops 20 # scrape 20 pages of tops category
$ stylemooncat pants "磨毛吊帶" 2 # scrape first two pages of pants category filter kw
$ stylemooncat latest 200 500 # scrape the latest category price matching 200 to 500
$ stylemooncat popular "Christmas" 400 500 2 # scrape 2 popular pages price 400 - 500
```
If you want to use it in your library:
```ruby
require 'stylemooncat'
scraper = StyleMoonCat::Scraper.new
results = scraper.latest(1)
```
The following functions are available:
```ruby
scraper.latest(page_number_to_scrape[, options])
scraper.popular(page_number_to_scrape[, options])
scraper.pants(page_number_to_scrape[, options])
scraper.tops(page_number_to_scrape[, options])
scraper.accessories(page_number_to_scrape[, options])
scraper.scrape(what_section_to_scrape[, options])
```
options is an optional hash having keyword, page_limit,
price_boundary (array two numbers)


The result of format is like:
````
[{:title=>"尖頭壓紋平底跟鞋*2色", :price=>"540", :images=>["http://www.stylemooncat.com.tw/photo/09070006/09070006.jpg"], :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24732"},
{:title=>"尖頭繫帶粗跟鞋*4色", :price=>"540", :images=>["http://www.stylemooncat.com.tw/photo/09050015/09050015.jpg"], :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24731"},
{:title=>"磨砂材質懶人鞋*2色", :price=>"590", :images=>["http://www.stylemooncat.com.tw/photo/09010016/09010016.jpg"], :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24820"}]
````
