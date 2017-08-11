class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:show, :edit, :update, :destroy]

  def index
    @friend_requests = FriendRequest.desc('_id')
    @friend_requests = @friend_requests.paginate(page: params[:page], per_page: 30)
  end

  def show
  end

  def new
    @friend_request = FriendRequest.new
  end

  def edit
  end

  def create
    @friend_request = FriendRequest.new(params[:friend_request].permit!)

    if @friend_request.save
      redirect_to(friend_requests_path, notice: 'Friend request 创建成功。')
    else
      render action: "new"
    end
  end

  def update
    if @friend_request.update_attributes(params[:friend_request].permit!)
      redirect_to(friend_requests_path, notice: 'Friend request 更新成功。')
    else
      render action: "edit"
    end
  end

  def destroy
    @friend_request.destroy
    redirect_to(friend_requests_path, notice: "删除成功。")
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
