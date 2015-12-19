#!/usr/bin/env ruby
require 'oga'
require 'open-uri'

# scrape data
module StyleMoonCat
  class Scraper
  # URI
    @@BASE_URI = 'http://www.stylemooncat.com.tw'

    @@NEW_ARRIVALS_URI = "#{@@BASE_URI}/PDList.asp?recommand=1312090001"

    @@TOP_URI  = "#{@@BASE_URI}/PDList.asp?p1=01"
    @@BOTTOM_URI = "#{@@BASE_URI}/PDList.asp?p1=02"
    @@OUTER_URI = "#{@@BASE_URI}/PDList.asp?p1=03"
    @@DRESS_URI = "#{@@BASE_URI}/PDList.asp?p1=04"

  # Selectors
    @@ITEM_XPATH      = "//div[contains(@class, 'goodsBox')]/div[contains(@class, 'good1')]"
    @@LINK_XPATH      = '/a'  # or a?
    @@IMAGE_XPATH    = "/a/img" # or a/img?
    @@TITLE_XPATH     = "/div[contains(@class, 'pd_info_1')]"
    @@PRICE_XPATH    = "/div[contains(@class, 'pd_info_1')]/span"

    # Regular ?
    @@TITLE_REGEX = /([．\p{Han}[a-zA-Z]]+)/

    def get_new_arrival(page)
      uri  = uri_with_page(@@NEW_ARRIVALS_URI, page)
      body = fetch_data(uri)
      filter(body)
    end

    private
    def uri_with_page(uri, page)
      "#{uri}&pageno=#{page}"
    end

    def fetch_data(uri)
      open(uri) {|file| file.read}
    end

    def filter(raw)
      Oga.parse_html(raw)
         .xpath(@@ITEM_XPATH)
         .map { |item| parse(item) }
    end

    def parse(item)
      {
        title:  extract_title(item),
        price:  extract_price(item),
        images: extract_images(item),
        link:   extract_link(item)
      }
    end

    def extract_title(item)
      item.xpath(@@TITLE_XPATH).text

    #  item.xpath(@@TITLE_SELECTOR).text
    #      .scan(@@TITLE_REGEX)
    #      .flatten[0]
    end

    def extract_price(item)
       item.xpath(@@PRICE_XPATH).text     # TWD.
    #  item.xpath(@@PRICE_XPATH).text.to_i
    end

    def extract_images(item)
      item.xpath(@@IMAGE_SELECTOR).attribute(:src).first.value
    end

    def extract_link(item)
      "#{@@BASE_URI}/#{item.xpath(@@LINK_XPATH).attribute(:href).first.value}"
    end
  end
end
