class Users::RolesController < ApplicationController
  # GET /users
  def index
    authorize! :manage, User
    @users = User.all
  end

  # GET /users/manage
  def manage
    @user = User.find(params[:id])
    authorize! :manage, @user
  end
end
