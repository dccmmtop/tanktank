module Admin
  class NodesController < Admin::ApplicationController
    before_action :set_node, only: [:show, :edit, :update, :destroy, :review]

    def index
      # @nodes = Node.sorted.includes(:section)
      @nodes = Node.circle_sorted
    end

    def show
    end

    def new
      @node = Node.new
    end

    def edit
    end

    def create
      @node = Node.new(params[:node].permit!)

      if @node.save
        redirect_to(admin_nodes_path, notice: 'Node was successfully created.')
      else
        render action: 'new'
      end
    end

    def update
      if @node.update_attributes(params[:node].permit!)
        redirect_to(admin_nodes_path, notice: 'Node was successfully updated.')
      else
        render action: 'edit'
      end
    end

    def destroy
      @node.destroy
      redirect_to(admin_nodes_url)
    end
    
    def review
      @node.update_attributes(audit: params[:audit])
      redirect_to(admin_nodes_path, notice: '操作成功.')
    end

    private

    def set_node
      @node = Node.find(params[:id])
    end
  end
end
