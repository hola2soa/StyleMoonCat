require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock/minitest'
require './lib/stylemooncat'

VCR.configure do |config|
  config.cassette_library_dir = './spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

VCR.use_cassette 'stylemooncat' do
  describe 'stylemooncat' do
    before do
      @scraper = StyleMoonCat::Scraper.new
    end

    describe 'fetch new arrival' do

      it 'should have correct format' do
        VCR.insert_cassette 'popular page 1'
        items = @scraper.get_new_arrival(1)
        item  = items.first

        items.must_be_instance_of Array
        items.wont_be_empty

        item.must_be_instance_of Hash
        item[:title].wont_be_nil
        item[:title].must_be_instance_of String
        item[:price].wont_be_nil
        item[:price].must_be_instance_of Fixnum
        item[:images].wont_be_nil
        item[:images].must_be_instance_of Array
        item[:link].wont_be_nil
        item[:link].must_be_instance_of String
        VCR.eject_cassette
      end
    end

  end
end
