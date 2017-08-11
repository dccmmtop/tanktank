class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]

  def index
    @keywords = Keyword.desc('_id')
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
      redirect_to(keywords_path, notice: 'Keyword 创建成功。')
    else
      render action: "new"
    end
  end

  def update
    if @keyword.update_attributes(params[:keyword].permit!)
      redirect_to(keywords_path, notice: 'Keyword 更新成功。')
    else
      render action: "edit"
    end
  end

  def destroy
    @keyword.destroy
    redirect_to(keywords_path, notice: "删除成功。")
  end

  private

  def set_keyword
    @keyword = Keyword.find(params[:id])
  end
end
