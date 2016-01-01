#!/usr/bin/env ruby
require 'oga'
require 'open-uri'
require 'open-uri-s3'

# scrape data
module StyleMoonCat
  class Scraper
  # URI
    @@BASE_URI = 'http://www.stylemooncat.com.tw'

    @@NEW_ARRIVALS_URI = "#{@@BASE_URI}/PDList.asp?recommand=1312090001"
    @@LAST_WEEK_URI = "#{@@BASE_URI}/PDList.asp?recommand=1312090002"
    @@SPECIAL_DISCOUNT_URI = "#{@@BASE_URI}/PDList.asp?recommand=1312090003"

    @@ALL_ITEMS_URI  = "#{@@BASE_URI}/PDList.asp?item1=00"
    @@TOP_URI  = "#{@@BASE_URI}/PDList.asp?p1=01"
      @@TOPS_Clothes_URI  = "#{@@BASE_URI}/PDList.asp?p1=01&p2=01"
      @@TOPS_Tshirt_URI  = "#{@@BASE_URI}/PDList.asp?p1=011&p2=02"
      @@TOPS_Vest_URI  = "#{@@BASE_URI}/PDList.asp?p1=01&p2=03"
      @@TOPS_Blouse_URI  = "#{@@BASE_URI}/PDList.asp?p1=01&p2=04"
      @@TOPS_Knit_URI  = "#{@@BASE_URI}/PDList.asp?p1=01&p2=05"
    @@BOTTOM_URI = "#{@@BASE_URI}/PDList.asp?p1=02"
      @@BOTTOM_Pants_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=01"
      @@BOTTOM_Skirts_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=02"
    @@OUTER_URI = "#{@@BASE_URI}/PDList.asp?p1=03"
      @@OUTER_Coat_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=01"
      @@OUTER_Jacket_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=02"
      @@OUTER_Knit_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=01"
      @@OUTER_Vest_URI  = "#{@@BASE_URI}/PDList.asp?p1=02&p2=02"
    @@DRESS_URI = "#{@@BASE_URI}/PDList.asp?p1=04"
    @@SHOES_AND_BAGS_URI = "#{@@BASE_URI}/PDList.asp?p1=05"
      @@SHOES_URI = "#{@@BASE_URI}/PDList.asp?p1=05&p2=01"
      @@BAG_URI = "#{@@BASE_URI}/PDList.asp?p1=05&p2=02"
    @@ACCESSORIES_URI = "#{@@BASE_URI}/PDList.asp?p1=06"
      @@ACCESSORIES_Watch_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=01"
      @@ACCESSORIES_Necklace_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=02"
      @@ACCESSORIES_Ring_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=03"
      @@ACCESSORIES_Bracelet_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=04"
      @@ACCESSORIES_Earring_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=05"
      @@ACCESSORIES_Muffler_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=06"
      @@ACCESSORIES_Belt_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=07"
      @@ACCESSORIES_Haircap_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=08"
      @@ACCESSORIES_Glasses_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=09"
      @@ACCESSORIES_Socks_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=10"
      @@ACCESSORIES_Underwear_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=11"
      @@ACCESSORIES_Others_URI = "#{@@BASE_URI}/PDList.asp?p1=06&p2=12"
  # Selectors
    @@ITEM_XPATH      = "//div[contains(@class, 'goodsBox')]/div[contains(@class, 'goodl')]"
    @@LINK_XPATH      = 'a'
    @@IMAGE_XPATH    = "a/img"
    @@TITLE_XPATH     = "div[contains(@class, 'pd_info_l')]"    # /div[contains(@class, 'pd_info_l')]   is wrong
    @@PRICE_SPAN_XPATH    = "div[contains(@class, 'pd_info_l')]/span"
    @@PRICE_STRIKE_XPATH    = "div[contains(@class, 'pd_info_l')]/strike"

    # Regular ?
    @@TITLE_REGEX = /([．\p{Han}[a-zA-Z]]+)/

    def scrape(category,page,keyword,price_from,price_to)
      case category
      when "newarrival"
            uri  = uri_with_page(@@NEW_ARRIVALS_URI, page)
      when "lastweek"
            uri  = uri_with_page(@@LAST_WEEK_URI, page)
      when "specialdiscount"
            uri  = uri_with_page(@@SPECIAL_DISCOUNT_URI, page)
      when "top"
            uri  = uri_with_page(@@TOP_URI, page)
          when "top_clothes"
                uri  = uri_with_page(@@TOPS_Clothes_URI, page)
          when "top_Tshirt"
                uri  = uri_with_page(@@TOPS_Tshirt_URI, page)
          when "top_vest"
                uri  = uri_with_page(@@TOPS_Vest_URI, page)
          when "top_blouse"
                uri  = uri_with_page(@@TOPS_Blouse_URI, page)
          when "top_knit"
                uri  = uri_with_page(@@TOPS_Knit_URI, page)
      when "bottom"
            uri  = uri_with_page(@@BOTTOM_URI, page)
          when "bottom_pants"
                uri  = uri_with_page(@@BOTTOM_Pants_URI, page)
          when "bottom_skirts"
                uri  = uri_with_page(@@BOTTOM_Skirts_URI, page)
      when "outer"
            uri  = uri_with_page(@@OUTER_URI, page)
          when "outer_coat"
                uri  = uri_with_page(@@OUTER_Coat_URI, page)
          when "outer_jacket"
                uri  = uri_with_page(@@OUTER_Jacket_URI, page)
          when "outer_knit"
                uri  = uri_with_page(@@OUTER_Knit_URI, page)
          when "outer_vest"
                uri  = uri_with_page(@@OUTER_Vest_URI, page)

      when "dress"
            uri  = uri_with_page(@@DRESS_URI, page)
      when "shoes_and_bag"
            uri  = uri_with_page(@@SHOES_AND_BAGS_URI, page)
          when "shose"
                uri  = uri_with_page(@@SHOES_URI, page)
          when "bag"
                uri  = uri_with_page(@@BAG_URI, page)
      when "accessories"
            uri  = uri_with_page(@@ACCESSORIES_URI, page)
          when "accessories_watch"
                uri  = uri_with_page(@@ACCESSORIES_Watch_URI, page)
          when "accessories_necklace"
                uri  = uri_with_page(@@ACCESSORIES_Necklace_URI, page)
          when "accessories_ring"
                uri  = uri_with_page(@@ACCESSORIES_Ring_URI, page)
          when "accessories_bracelet"
                uri  = uri_with_page(@@ACCESSORIES_Bracelet_URI, page)
          when "accessories_earring"
                uri  = uri_with_page(@@ACCESSORIES_Earring_URI, page)
          when "accessories_muffler"
                uri  = uri_with_page(@@ACCESSORIES_Muffler_URI, page)
          when "accessories_belt"
                uri  = uri_with_page(@@ACCESSORIES_Belt_URI, page)
          when "accessories_haircap"
                uri  = uri_with_page(@@ACCESSORIES_Haircap_URI, page)
          when "accessories_glasses"
              uri  = uri_with_page(@@ACCESSORIES_Glasses_URI, page)
          when "accessories_socks"
              uri  = uri_with_page(@@ACCESSORIES_Socks_URI, page)
          when "accessories_underwear"
              uri  = uri_with_page(@@ACCESSORIES_Underwear_URI, page)
          when "accessories_others"
              uri  = uri_with_page(@@ACCESSORIES_Others_URI, page)
      else
            uri  = uri_with_page(@@ALL_ITEMS_URI, page)
      end

      if (keyword != "none") &&  (keyword != nil)
          uri = uri_with_keyword(uri,keyword)
      end
      puts uri
      body = fetch_data(uri)
      filter_results = filter(body)
      #filter with price if there are correct price parameters
      if price_to!=nil && price_from!=nil && price_to.to_i >=price_from.to_i  && price_from.to_i !=-1 && price_to.to_i !=-1
        return filter_results.select{|x| x[:price].to_i<=price_to.to_i && x[:price].to_i>=price_from.to_i }
      else
        return filter_results
      end
    end


    private
    def uri_with_keyword(uri, keyword)
      "#{uri}&keyword=#{keyword}"
    end

    def uri_with_page(uri, page)
      "#{uri}&pageno=#{page}"
    end

    def fetch_data(uri)
    #  puts uri
      open(uri) {|file| file.read}
    end

    def filter(raw)
    #  puts Oga.parse_html(raw).xpath(@@ITEM_XPATH).map { |item| parse(item) }
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
        item.xpath(@@TITLE_XPATH).text.split("TWD")[0]
    end

    def extract_price(item)

      # if there is discount, priceString format is "originPirce sellingPrice"
      # .split(' ') is fail. so use this method to extract sellingPrice
      priceString = item.xpath(@@TITLE_XPATH).text.split("TWD.")[1]
      length = priceString.length
      if length ==8 || length ==9  #ex: priceString ==  "1200 990"   or "1200 1100"
          space = priceString[4]
          result = priceString.split(space)[1]
      elsif length ==7 || length ==6 #ex: priceString == "999 990"  or   "120 99"
          space = priceString[3]
          result = priceString.split(space)[1]
      elsif length ==5 #ex: priceString == "99 90"
            space = priceString[2]
            result = priceString.split(space)[1]
      else #no discount
            result = priceString
      end

      result
    end

    def extract_images(item)
      item.xpath(@@IMAGE_XPATH).attribute(:src).first.value
    end

    def extract_link(item)
      "#{@@BASE_URI}/#{item.xpath(@@LINK_XPATH).attribute(:href).first.value}"
    end
  end
end
