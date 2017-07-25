module Car
  class RegistrationController < ApplicationController
    before_action :authorize

    def index
      @registrations = current_user.car_registrations
    end

    def register; end

    def create_registration
      flash[:success] = "createds registration!!"
      redirect_to car_registration_path
    end

    def end_registration; end

    def change_registration; end

    private

    def authorize
      authorize! :manage, CarRegistration
    end
  end
end
