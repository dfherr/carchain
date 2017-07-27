require 'rails_helper'

RSpec.describe Users::RolesController, type: :controller do
  let(:admin_user) {
    u = create(:confirmed_user)
    u.add_role :admin
    u
  }

  before :each do
    sign_in admin_user
  end

  describe "GET index" do
    it "renders the user roles overview" do
      get :index
      expect(response).to render_template("index")
    end

    it "assign users" do
      get :index
      users = User.all
      expect(assigns(:users)).to match_array users
    end
  end

  describe "GET manage" do
    it "renders the manage view" do
      get :manage, params: { id: admin_user.id }
      expect(response).to render_template("manage")
    end

    it "assign user" do
      get :index
      get :manage, params: { id: admin_user.id }
      expect(assigns(:user)).to eq admin_user
    end
  end

  describe "POST add" do
    it "redirect to the manage view" do
      post :add, params: { id: admin_user.id, user: { roles: { name: "test" } } }
      expect(response).to redirect_to(users_roles_manage_url)
    end

    it "adds role to user" do
      expect(admin_user.has_role?(:test)).to be_falsey
      post :add, params: { id: admin_user.id, user: { roles: { name: "test" } } }
      expect(admin_user.has_role?(:test)).to be_truthy
    end
  end

  describe "DELETE destroy" do
    it "redirect to the manage view" do
      delete :destroy, params: { id: admin_user.id, role_id: 1 }
      expect(response).to redirect_to(users_roles_manage_url)
    end

    it "deletes the role from user" do
      admin_user.add_role :test
      expect(admin_user.has_role?(:test)).to be_truthy
      role_id = Role.find_by(name: :test).id
      delete :destroy, params: { id: admin_user.id, role_id: role_id }
      expect(admin_user.has_role?(:test)).to be_falsey
    end
  end
end
