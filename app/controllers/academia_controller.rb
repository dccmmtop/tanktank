class AcademiaController < ApplicationController
  def index
    @academia = Academium.all.order(id: :desc).paginate page: params[:page], per_page: 30
  end
  
  def show
    @academium = Academium.find(params[:id])
  end
end