module Admin
  class OrganisationsController < Admin::ApplicationController
    before_action :set_organisation, only: [:show, :edit, :update, :destroy]

    def index
      @organisations = Organisation.all
      if(params[:q])
        key = params[:q].strip
        @organisations = @organisations.where('ticker LIKE ? or name LIKE ?', "%#{key}%", "%#{key}%")
      end
      @organisations = @organisations.order(id: :desc).paginate page: params[:page], per_page: 30
    end

    def show
    end

    def new
      @organisation = Organisation.new
    end

    def edit
    end

    def create
      @organisation = Organisation.new(organisation_params)

      if @organisation.save
        redirect_to(admin_organisations_path, notice: 'Organisation was successfully created.')
      else
        render action: 'new'
      end
    end

    def update
      if @organisation.update_attributes(organisation_params)
        redirect_to(admin_organisations_path, notice: 'Organisation was successfully updated.')
      else
        render action: 'edit'
      end
    end

    def destroy
      @organisation.destroy
      redirect_to(admin_organisations_url)
    end

    private

    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    def organisation_params
      params.require(:organisation).permit!
    end
  end
end
