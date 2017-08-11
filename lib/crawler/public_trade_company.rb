module Crawler
  class PublicTradeCompany
    class << self
      
      def search_threeboard(token, page)
        os = []
        url = "http://www.iwencai.com/threeboard/cache?token=#{token}&p=#{page}&perpage=30"
        json = get_data(url)
        if json['result'].present?
          json['result'].each do |r|
            o = { ticker: r.at(0), name: r.at(1), market_value: r.at(2), price_to_earning: r.at(3), industry: r.at(7), website: r.at(6)}
            os << o
          end
        else
          puts "=== sorry, boy"
        end
        os
      end

      def get_data(url)
        encoded_url = URI.encode(url)
        target = URI.parse(encoded_url)
        http = Net::HTTP.new(target.host, target.port) 
        request = Net::HTTP::Get.new(target.request_uri)
        response = http.request(request)
        json = JSON.parse(response.body)
        json
      end

      def search_telephone(token, page)
        os = []
        url = "http://www.iwencai.com/stockpick/cache?token=#{token}&p=#{page}&perpage=10"
        json = get_data(url)
        if json['result'].present?
          json['result'].each do |r|
            o = { ticker: r.at(0), name: r.at(1), telephone: r.at(4), industry: r.at(5), concept: r.at(6), website: r.at(7), email: r.at(9), office_address: r.at(10), legal_representative: r.at(11)}
            os << o
          end
        else
          puts "=== sorry, boy"
        end
        os
      end


      def search_company(token, page)
        os = []
        url = "http://www.iwencai.com/stockpick/cache?token=#{token}&p=#{page}&perpage=10"
        json = get_data(url)
        if json['result'].present?
          json['result'].each do |r|
            o = { ticker: r.at(0), name: r.at(1), full_name: r.at(4), concept: r.at(5), industry: r.at(8), city: r.at(7)}
            os << o
          end
        else
          puts "=== sorry, boy"
        end
        os
      end


      def search_main_product(token, page)
        os = []
        url = "http://www.iwencai.com/stockpick/cache?token=#{token}&p=#{page}&perpage=10"
        json = get_data(url)
        if json['result'].present?
          json['result'].each do |r|
            o = { ticker: r.at(0), name: r.at(1), main_product: r.at(4), industry: r.at(6), website: r.at(7)}
            os << o
          end
        else
          puts "=== sorry, boy"
        end
        os
      end

    end
  end
end