class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @events = Event.all.order('id desc')
    @events = @events.paginate(page: params[:page], per_page: 30)
  end

  def show
  end

  def new
    @event = Event.new(user_id: current_user.id)
  end

  def edit
  end

  def create
    @event = Event.new(params[:event].permit!)
    @event.user_id = current_user.id
    if @event.save
      redirect_to(events_path, notice: 'Event 创建成功。')
    else
      render action: "new"
    end
  end

  def update
    if @event.update_attributes(params[:event].permit!)
      redirect_to(events_path, notice: 'Event 更新成功。')
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to(events_path, notice: "删除成功。")
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
