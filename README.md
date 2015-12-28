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

1.Run it from the command line:
```
$ stylemooncat #{category} #{page} #{keyword} #{price_from} #{price_to}
```
For example, to get the items which are in page 1 of 'top' category ,its title contains 'MOONCAT' ,its price range is from $400 to $500:
```
$ stylemooncat top 1 MOONCAT 400 500
```

If you don't want search by keyword, let keyword be "none":
```
$ stylemooncat top 1 none 400 500
```

If you don't want search by category, let category be "allitems":
```
$ stylemooncat allitems 1 MOONCAT 400 500
```
If you don't want search by price range, let price_from or price_to be -1 or ignore these parameters
```
$ stylemooncat allitems 1 MOONCAT -1 -1
```
or
```
$ stylemooncat allitems 1 MOONCAT
```



2.Use it from your Ruby code(similar with the above):

Get the items which are in page 1 of 'top' category ,its title contains 'MOONCAT' ,its price range is from $400 to $500:

````ruby
require 'stylemooncat'
scraper = StyleMoonCat::Scraper.new
# scrape(#{category} ,#{page} ,#{keyword} ,#{price_from}, #{price_to}) ,and #{price_from} should <= #{price_to}
results = scraper.scrape("top",1,"MOONCAT",400,500)
````

Please see http://www.stylemooncat.com.tw/ , category can be 'allitems','newarrival','lastweek','specialdiscount','top','bottom','outer','shose','bag', or 'accessories'

If you don't want search by keyword, let keyword be "none":
````
results = scraper.scrape("top",1,"none",400,500)
````

If you don't want search by price range, let price_from or price_to be -1
```
results = scraper.scrape("top",1,"MOONCAT",-1,-1)
```

If you don't want search by category, let category be 'allitems'
```
results = scraper.scrape("allitems",1,"MOONCAT",400,500)
```


The result of format is like:
````
{:title=>"立領坑條細織背心*9色", :price=>"280", :images=>"/photo/01080327/01080327.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24125-dn"}
{:title=>"羅紋立領合身毛衣*4色", :price=>"330", :images=>"/photo/01110084/01110084.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"}
{:title=>"尖頭壓紋平底跟鞋*2色", :price=>"540", :images=>"/photo/09070006/09070006.jpg", :link=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24732"}
````
