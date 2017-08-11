module Admin
  class KeywordsController < Admin::ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    
    def index
      @keywords = Keyword.all
      if params[:q]
        @keywords = Keyword.search(params[:q])
      end
      @keywords = @keywords.paginate(page: params[:page], per_page: 30)
    end
    
    def show
    end
    
    def new
      @keyword = Keyword.new
    end
    
    def edit
    end
    
    def create
      @keyword = Keyword.new(params[:keyword].permit!)
    
      if @keyword.save
        redirect_to(admin_keywords_path, notice: '创建成功。')
      else
        render action: "new"
      end
    end
    
    def update
      if @keyword.update_attributes(params[:keyword].permit!)
        redirect_to(admin_keywords_path, notice: '更新成功。')
      else
        render action: "edit"
      end
    end
    
    def destroy
      @keyword.destroy
      redirect_to(admin_keywords_path, notice: "删除成功。")
    end
    
    private
    
    def set_item
      @keyword = Keyword.find(params[:id])
    end
  end
end
