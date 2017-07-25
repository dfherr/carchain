class Users::RolesController < ApplicationController
  # GET /users
  def index
    authorize! :manage, User
    @users = User.all.order(:id)
  end

  # GET /users/manage
  def manage
    @user = User.find(params[:id])
    authorize! :manage, @user
  end

  def add
    user = User.find(params[:id])
    authorize! :manage, user
    role_name = params[:user][:roles][:name].strip.gsub(/(_|\s)+/, "_")
    if role_name.empty?
      flash[:alert] = _("Role may not be empty!")
    elsif user.has_role? role_name
      flash[:notice] = _("User #%{user} already has role %{role}.") % { user: user.id, role: role_name }
    elsif user.add_role role_name
      flash[:success] = _("Role %{role} added to user #%{user}") % { user: user.id, role: role_name }
    else
      flash[:alert] = _("Could not add role %{role} to user #%{user}") % { user: user.id, role: role_name }
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
        puts old_ability.can?(:manage, user)
        puts Ability.new(user).cannot?(:manage, user)
        if old_ability.can?(:manage, user) && Ability.new(user).cannot?(:manage, user)
          user.add_role role.name.to_sym
          flash[:alert] = _("You can't remove that role, because the user could no longer manage roles.")
        else
          flash[:success] = _("Role %{role} removed from user #%{user}") % { user: user.id, role: role.name }
        end
      else
        flash[:alert] = _("Could not remove role %{role} from user #%{user}") % { user: user.id, role: role.name }
      end
    end
    redirect_to users_roles_manage_url
  end
end
