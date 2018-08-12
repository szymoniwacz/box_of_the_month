module V1
  class PlansController < ApplicationController
    before_action :allow_page_caching
    
    def index
      render json: {
        plans: Plan.all
      }
    end
  end
end
