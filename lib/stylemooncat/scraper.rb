#!/usr/bin/env ruby
require 'oga'
#require 'iconv'
require 'open-uri'

# scrape data
module StyleMoonCat
  # extract_data class uses xpath selectors to get attribs
  class Scraper
    BASE_URL        = 'http://www.stylemooncat.com.tw'
    BASE_SCRAPE_URL = "#{BASE_URL}/PDList.asp?"

    SEARCH_URI      = "#{BASE_URL}item1=00"
    LATEST_URI      = "#{BASE_SCRAPE_URL}recommand=1312090001"
    POPULAR_URI     = "#{BASE_SCRAPE_URL}/recommand=1312090003"
    TOPS_URI        = "#{BASE_SCRAPE_URL}p1=01"
    PANTS_URI       = "#{BASE_SCRAPE_URL}p1=02&p2=01"
    ACCESSORIES_URI = "#{BASE_SCRAPE_URL}p1=06"

    # xml selectors that will be used to scrape data
    ITEM_SELECTOR   = "//div[@class='goodsBox']/div[@class='goodl']"
    TITLE_SELECTOR  = "div[@class='pd_info_l']//text()[not(parent::span)]"
    IMAGE_SELECTOR  = "a/img/@src"
    PRICE_SELECTOR  = "div[@class='pd_info_l']/span//text()[not(parent::strike)]"
    LINK_SELECTOR   = "a/@href"

    def latest(page, options = {})
      uri  = uri_with_options(build_uri(LATEST_URI, options), page)
      process_request(uri, options)
    end

    def popular(page, options = {})
      uri  = uri_with_options(build_uri(POPULAR_URI, options), page)
      process_request(uri, options)
    end

    def tops(page, options = {})
      uri  = uri_with_options(build_uri(TOPS_URI, options), page)
      process_request(uri, options)
    end

    def pants(page, options = {})
      uri  = uri_with_options(build_uri(PANTS_URI, options), page)
      process_request(uri, options)
    end

    def accessories(page, options = {})
      uri  = uri_with_options(build_uri(ACCESSORIES_URI, options), page)
      process_request(uri, options)
    end

    def search(page, options = {})
      uri  = uri_with_options(build_uri(BASE_SCRAPE_URL, options), page)
      process_request(uri, options)
    end

    def scrape(type, options = {})
      records = []
      valid_args = [:tops, :popular, :pants, :pants,
        :accessories, :latest, :search]
      abort 'invalid parameter - scrape type' unless valid_args.include?(type.to_sym)
      scrape_what(type, options)
    end

    private

    def process_request(uri, options)
      body = open_uri(uri)
      data = extract_data(body)
      filter(data, options)
    end

    # filter by price if the options are not empty
    def filter(data, options)
      results = data
      unless options.empty?
        results = match_price(results, options[:price_boundary]) if options[:price_boundary]
      end
      results
    end

    # do the actual extraction of prices from the result set
    def match_price(data, boundary)
      lower_bound = boundary.first || 0
      upper_bound = boundary.last  || Float::INFINITY

      data.select { |item| lower_bound <= item[:price] && item[:price] <= upper_bound }
    end

    def build_uri(uri, options = {})
      opts = { uri: uri }
      unless options.empty?
        opts[:keyword] = options[:keyword] if options[:keyword]
      end
      opts
    end

    def uri_with_options(options = {}, page)
      uri = ''
      unless options.empty?
        kw = options[:keyword] || nil
        #ic = Iconv.new('big5','UTF-8')
        keyword = kw
        uri << "#{options[:uri]}&pageno=#{page}" if options[:uri]
        uri << "br=X&keyword=#{URI.escape(keyword)}" if options[:keyword]
      end
      uri
    end

    # try open the URL, fail on error
    def open_uri(uri)
      open(uri) {|file| file.read}
    rescue StandardError
      'error opening site url'
    end

    # iterate over every element of item using xpath
    def extract_data(raw)
      Oga.parse_html(raw)
         .xpath(ITEM_SELECTOR)
         .map { |item| parse(item) }
    end

    # call methods to extract the data using xpath
    def parse(item)
      {
        title:  extract_title(item),
        price:  extract_price(item),
        images: extract_images(item),
        link:   extract_link(item)
      }
    end

    # Iconv is neccessary here otherwise text is unreadable
    def extract_title(item)
    #  ic = Iconv.new('UTF-8','big5')
      raw_title = item.xpath(TITLE_SELECTOR).text
  #    ic.iconv(raw_title)
    end

    # get rid of the NT and convert to integer
    def extract_price(item)
      price_str = item.xpath(PRICE_SELECTOR).text
      price_str.sub(/TWD./, '').gsub("\u00a0", ' ').to_i
    end

    # extract two images and return array or urls
    def extract_images(item)
      image       = item.xpath(IMAGE_SELECTOR).text
      # image_hover = image.sub(/\.jpg/, '-h.jpg')
      # image_hover = image.sub(/\.png/, '-h.png') unless image_hover != image
      ["#{BASE_URL}#{image}"]
    end

    # get the link to the item
    def extract_link(item)
      "#{BASE_URL}/#{item.xpath(LINK_SELECTOR).text}"
    end

    def scrape_what(type, options)
      records = []
      pl = options[:page_limit].to_i
      page_limit = pl != 0 ? pl : 5

      1.upto(page_limit) do |page|
        method = self.method(type)
        records.push(method.call(page, options))
      end
      records.reject { |c| c.empty? }.flatten(1).uniq
    end
  end
end
