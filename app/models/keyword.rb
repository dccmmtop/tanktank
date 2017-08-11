class Keyword < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  belongs_to :user
  counter :hits, default: 0
  
  def self.hot(ws)
    ws.each do |w|
      keyword = Keyword.find_by(name: w)
      if keyword
        keyword.hits.incr(1)
      end
    end
  end
  
  def self.get_hot    
    Keyword.all.each do |kw|
      kw.update_attributes(using_count: kw.hits)
    end
    @keywords = Keyword.all.order(using_count: :desc)
  end
  
  def self.set_interest(user, interest)
    if interest.include?(',')
      interest.split(',').each do |i|
        Keyword.create(user_id: user.id, name: i)  
      end
    else
      Keyword.create(user_id: user.id, name: interest)  
    end
  end
end
