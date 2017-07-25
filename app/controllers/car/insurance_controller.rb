module Car
  class InsuranceController < ApplicationController
    before_action :authorize

    def search_for_registration; end

    private

    def authorize
      authorize! :manage, InsuranceController
    end
  end
end
