class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.all.order(id: :desc).paginate page: params[:page], per_page: 30
  end
  
  def show
    @organisation = Organisation.find(params[:id])
  end
  
end