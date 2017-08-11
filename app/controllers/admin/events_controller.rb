module Admin
  class EventsController < Admin::ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    
    def index
      @events = Event.all
      if params[:q]
        @events = Event.search(params[:q])
      end
      @events = @events.paginate(page: params[:page], per_page: 30)
    end
    
    def show
    end
    
    def new
      @event = Event.new
    end
    
    def edit
    end
    
    def create
      @event = Event.new(params[:event].permit!)
    
      if @event.save
        redirect_to(admin_events_path, notice: '创建成功。')
      else
        render action: "new"
      end
    end
    
    def update
      if @event.update_attributes(params[:event].permit!)
        redirect_to(admin_events_path, notice: '更新成功。')
      else
        render action: "edit"
      end
    end
    
    def destroy
      @event.destroy
      redirect_to(admin_events_path, notice: "删除成功。")
    end
    
    private
    
    def set_event
      @event = Event.find(params[:id])
    end
  end
end
