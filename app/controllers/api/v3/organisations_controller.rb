module Api
  module V3
    class OrganisationsController < Api::V3::ApplicationController
      before_action :doorkeeper_authorize!, except: [:index]
     

      def index
        optional! :page, default: 1
        
        items = Organisation.all.paginate page: params[:page], per_page: 30
        render json: items
      end
    end
  end
end