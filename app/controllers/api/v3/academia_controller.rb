module Api
  module V3
    class AcademiaController < Api::V3::ApplicationController
      before_action :doorkeeper_authorize!, except: [:index]
     

      def index
        optional! :page, default: 1
        
        @academia = Academium.all
        @academia = @academia.paginate page: params[:page], per_page: 30
        render json: @academia
      end
    end
  end
end