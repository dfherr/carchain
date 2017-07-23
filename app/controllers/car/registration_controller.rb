module Car
  class RegistrationController < ApplicationController
    def register
      authorize! :manage, Registration
    end

    def end_registration
      authorize! :manage, Registration
    end

    def change_registration
      authorize! :manage, Registration
    end
  end
end
