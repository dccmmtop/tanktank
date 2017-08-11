class Organisation < ApplicationRecord
  include Searchable
  validates :name, presence: true
  validates :ticker, presence: true
  
  mapping do
    indexes :name
    indexes :ticker
    indexes :industry
  end
  
  
  class << self

    def get_threeboard(token, pages)
      original = "http://www.iwencai.com/threeboard/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=threeboard&searchfilter=&tid=stockpick&w=%E7%BD%91%E5%9D%80+%E8%A1%8C%E4%B8%9A"
      pages.to_i.times do |p|
        Rails.logger.debug("===== page is #{p+1}")
        Crawler::PublicTradeCompany.search_threeboard(token, p+1).each do |o|
          create_data(o)
        end
      end
    end

    def get_main_product(token, pages)
      original = "http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E4%B8%BB%E8%90%A5%E4%BA%A7%E5%93%81%E5%90%8D%E7%A7%B0"
      pages.to_i.times do |p|
        Rails.logger.debug("===== page is #{p+1}")
        Crawler::PublicTradeCompany.search_main_product(token, p+1).each do |o|
          create_data(o)
        end
      end
    end
    
    def get_telephone(token, pages) 
      original = "http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E7%94%B5%E8%AF%9D+%E8%A1%8C%E4%B8%9A"
      pages.to_i.times do |p|
        Crawler::PublicTradeCompany.search_telephone(token, p+1).each do |o|
          create_data(o)
        end
      end
    end

    def get_company(token, pages)
      original = "http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E5%85%AC%E5%8F%B8%E5%90%8D%E7%A7%B0"
      pages.to_i.times do |p|
        Crawler::PublicTradeCompany.search_company(token, p+1).each do |o|
          create_data(o)
        end
      end
    end
    
    def create_data(parameters)
      if (organisation = Organisation.find_by(ticker: parameters[:ticker]))
        organisation.update_attributes(parameters)
      else
        o = Organisation.new(parameters)
        o.save
      end
    end
  
  end
end
