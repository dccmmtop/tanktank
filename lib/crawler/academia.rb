module Crawler
  class Academia
    class << self
      
      def get_data
        datas =[]
        url = "http://www.grs.ynu.edu.cn/ckfinder/userfiles/grs/files/468全国各学位授予单位代码.htm"
        encoded_url = URI.encode(url)
        target = URI.parse(encoded_url)
        doc = Nokogiri::HTML(open("#{target}"))
        
        doc.css('p').each do |node|
          data = node.css('span[style="font-size:9.0pt"]').text
          if data.present?
            
            arr = data.split
            datas << {name: arr[1], code: arr[0]}
          end
        end
        datas
      end
      
    end    
  end
end