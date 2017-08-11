module Admin
  class AcademiaController < Admin::ApplicationController
    before_action :set_academium, only: [:show, :edit, :update, :destroy]
    
    def import
      Academium.get_excel_data(params[:file])
      redirect_to admin_academia_path, notice: "导入成功"
    end

    def index
      @academia = Academium.all
      if params[:q]
        @academia = Academium.search(params[:q])
      end
      @academia = @academia.paginate(page: params[:page], per_page: 30)
    end
    
    def show
    end
    
    def new
      @academium = Academium.new
    end
    
    def edit
    end
    
    def create
      @academium = Academium.new(params[:academium].permit!)
    
      if @academium.save
        redirect_to(admin_academia_path, notice: 'Academium 创建成功。')
      else
        render action: "new"
      end
    end
    
    def update
      if @academium.update_attributes(params[:academium].permit!)
        redirect_to(admin_academia_path, notice: 'Academium 更新成功。')
      else
        render action: "edit"
      end
    end
    
    def destroy
      @academium.destroy
      redirect_to(admin_academia_path, notice: "删除成功。")
    end
    
    private
    
    def set_academium
      @academium = Academium.find(params[:id])
    end
  end
end
