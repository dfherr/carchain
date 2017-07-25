module Car
  class PoliceController < ApplicationController
    before_action :authorize

    def search_for_owner; end

    private

    def authorize
      authorize! :manage, PoliceController
    end
  end
end
