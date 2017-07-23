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
