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

  def add
    user = User.find(params[:id])
    authorize! :manage, user
    role_name = params[:user][:roles][:name].to_sym
    if user.has_role? role_name
      flash[:notice] = "User ##{user.id} already has role #{role_name}."
    elsif user.add_role role_name
      flash[:success] = "Role #{role_name} added to user ##{user.id}"
    else
      flash[:alert] = "Could not add role #{role_name} to user ##{user.id}"
    end

    redirect_to users_roles_manage_url
  end

  def destroy
    user = User.find(params[:id])
    authorize! :manage, user
    role = Role.find(params[:role_id])
    old_ability = Ability.new(user)
    ActiveRecord::Base.transaction do
      if user.roles.destroy(role)
        if old_ability.can?(:manage, user) && Ability.new(user).cannot?(:manage, user)
          user.add_role role.name.to_sym
          flash[:alert] = "You can't remove that role, because user could no longer manage roles."
        else
          flash[:success] = "Role #{role.name} removed from user ##{user.id}"
        end
      else
        flash[:alert] = "Could not remove role #{role.name} from user ##{user.id}"
      end
    end
    redirect_to users_roles_manage_url
  end
end
