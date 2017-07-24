module Car
  class RegistrationController < ApplicationController
    def register
      authorize! :manage, Registration
    end

    def create_registration
      authorize! :manage, Registration

      flash[:success] = "createds registration!!"
      redirect_to car_registration_path
    end

    def end_registration
      authorize! :manage, Registration
    end

    def change_registration
      authorize! :manage, Registration
    end
  end
end
