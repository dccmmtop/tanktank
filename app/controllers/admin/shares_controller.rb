module Admin
class SharesController < Admin::ApplicationController
  before_action :set_share, only: [:show, :edit, :update, :destroy]

  def index
    @shares = Share.order('id desc')
    @shares = @shares.paginate(page: params[:page], per_page: 30)
  end

  def show
  end

  def new
    @share = Share.new
  end

  def edit
  end

  def create
    @share = Share.new(params[:share].permit!)

    if @share.save
      redirect_to(shares_path, notice: 'Share 创建成功。')
    else
      render action: "new"
    end
  end

  def update
    if @share.update_attributes(params[:share].permit!)
      redirect_to(shares_path, notice: 'Share 更新成功。')
    else
      render action: "edit"
    end
  end

  def destroy
    @share.destroy
    redirect_to(shares_path, notice: "删除成功。")
  end

  private

  def set_share
    @share = Share.find(params[:id])
  end
end

end
