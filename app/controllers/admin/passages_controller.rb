module Admin
  class PassagesController < Admin::ApplicationController
  before_action :set_passage, only: [:show, :edit, :update, :destroy]

  def index
    @passages = Passage.order(id: :desc)
    if params[:q]
      @passages = @passages.search(params[:q])
    end
    @passages = @passages.paginate(page: params[:page], per_page: 30)
    @passages_for_audit= Passage.auditing
  end

  def show
  end

  def new
    @passage = Passage.new
  end

  def edit
    @audits = @passage.audits.created_order
  end

  def create
    @passage = Passage.new(params[:passage].permit!)

    if @passage.save
      redirect_to(passages_path, notice: 'Passage 创建成功。')
    else
      render action: "new"
    end
  end

  def update
    if @passage.update_attributes(params[:passage].permit!)
      redirect_to(admin_passages_path, notice: 'Passage 更新成功。')
      @passage.audits.create(:content => @passage.comment, :status => @passage.status)
    else
      render action: "edit"
    end
  end

  def destroy
    @passage.destroy
    redirect_to(admin_passages_path, notice: "删除成功。")
  end

  private

  def set_passage
    @passage = Passage.find(params[:id])
  end
end
end
