require "rails_helper"

RSpec.describe Users::ConfirmationsController, type: :routing do
  describe "routing" do
    it "get /users/confirmation/new routes to users/confirmations#new" do
      expect(get: "/users/confirmation/new").to route_to("users/confirmations#new")
    end

    it "post /users/confirmation routes to users/confirmations#create" do
      expect(post: "/users/confirmation").to route_to("users/confirmations#create")
    end

    it "get /users/confirmation routes to users/confirmations#show" do
      expect(get: "/users/confirmation").to route_to("users/confirmations#show")
    end
  end
end

RSpec.describe Users::PasswordsController, type: :routing do
  describe "routing" do
    it "get /users/password/new routes to users/passwords#new" do
      expect(get: "/users/password/new").to route_to("users/passwords#new")
    end

    it "post /users/password routes to users/passwords#create" do
      expect(post: "/users/password").to route_to("users/passwords#create")
    end

    it "get /users/password/edit routes to users/passwords#edit" do
      expect(get: "/users/password/edit").to route_to("users/passwords#edit")
    end

    it "put /users/password routes to users/passwords#update" do
      expect(put: "/users/password").to route_to("users/passwords#update")
    end
  end
end

RSpec.describe Users::RegistrationsController, type: :routing do
  describe "routing" do
    it "get /users/sign_up routes to users/registrations#new" do
      expect(get: "/users/sign_up").to route_to("users/registrations#new")
    end

    it "post /users routes to users/registrations#create" do
      expect(post: "/users").to route_to("users/registrations#create")
    end

    it "get /users/edit routes to users/registrations#edit" do
      expect(get: "/users/edit").to route_to("users/registrations#edit")
    end

    it "put /users routes to users/registrations#update" do
      expect(put: "/users").to route_to("users/registrations#update")
    end

    it "delete /users routes to users/registrations#destroy" do
      expect(delete: "/users").to route_to("users/registrations#destroy")
    end
  end
end

RSpec.describe Users::SessionsController, type: :routing do
  describe "routing" do
    it "get /users/sign_in routes to users/sessions#new" do
      expect(get: "/users/sign_in").to route_to("users/sessions#new")
    end

    it "post /users/sign_in routes to users/sessions#create" do
      expect(post: "/users/sign_in").to route_to("users/sessions#create")
    end

    it "delete /users/sign_out routes to users/sessions#destroy" do
      expect(delete: "/users/sign_out").to route_to("users/sessions#destroy")
    end
  end
end

RSpec.describe Users::UnlocksController, type: :routing do
  describe "routing" do
    it "get /users/unlock/new routes to users/unlocks#new" do
      expect(get: "/users/unlock/new").to route_to("users/unlocks#new")
    end

    it "post /users/unlock routes to users/unlocks#create" do
      expect(post: "/users/unlock").to route_to("users/unlocks#create")
    end

    it "get /users/unlock routes to users/unlocks#show" do
      expect(get: "/users/unlock").to route_to("users/unlocks#show")
    end
  end
end
