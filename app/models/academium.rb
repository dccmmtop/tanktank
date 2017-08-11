require 'roo'

class Academium < ApplicationRecord
  validates :name, presence: true
  
  include Searchable

  mapping do
    indexes :name
  end
  
  
  HEADERS=[
        :name, :superior_department, :local, :level, :remark
    ]
  class << self
    def search(q)
      datas = Academium.where('name like ?', "%#{q}%")
      datas
    end
    
    def get_excel_data(file)
      spreadsheet = open_spreadsheet(file) 
      (2..spreadsheet.last_row).each do |line|
        row = {}
        if(spreadsheet.cell(line, 2)).present?        
          HEADERS.each_with_index do |k, i|
            row[k] = spreadsheet.cell(line, i+2).to_s.strip
          end
          Rails.logger.debug("#{row}")
          create_or_update_data(row)
        end
        
        
      end
    end
    
    def open_spreadsheet(file)
      Rails.logger.debug("#{file.tempfile.to_path.to_s}")
      Rails.logger.debug("#{file.path.to_s}")
      case File.extname(file.original_filename)
        when ".csv" then Csv.new(file.path, nil, :ignore)
        when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
    
    def get_url_data
      Crawler::Academia.get_data.each do |item|
        create_or_update_data(item)
      end
    end
    
    def create_or_update_data(params)
      if (a=find_by(name: params[:name]))
        a.update_attributes(params)
      else
        create(params)
      end
    end
  end
  

end
