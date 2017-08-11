class Search
  class << self
    def query(q, page)
      search_modules = [Topic]
      search_modules << Page if Setting.has_module?(:wiki)
      search_modules << Organisation
      search_modules << Academium
      search_params = {
        query: {
          simple_query_string: {
            query: q,
            default_operator: 'AND',
            minimum_should_match: '70%',
            fields: %w(title body name tags login industry)
          }
        },
        highlight: {
          pre_tags: ['[h]'],
          post_tags: ['[/h]'],
          fields: { title: {}, body: {}, name: {}, tags: {}, login: {}, industry: {} }
        }
      }
      Elasticsearch::Model.search(search_params, search_modules).paginate(page: page, per_page: 30)
    end
    
    def wechat_query(q)
      Rails.logger.info("========= #{q}")
      search_modules = [Topic]
      search_params = {
        query: {
          simple_query_string: {
            query: q,
            default_operator: 'OR',
            minimum_should_match: '60%',
            fields: %w(title body name tags)
          }
        },
        highlight: {
          pre_tags: ['[h]'],
          post_tags: ['[/h]'],
          fields: { title: {}, body: {}, name: {}, tags: {} }
        }
      }
      Elasticsearch::Model.search(search_params, search_modules)
    end
    
    def user_interest_query(query)
      items = []
      query.split(',').each do |q|
        qs = wechat_query(q).records
        items = items | qs
      end
      items
    end  
  end
end