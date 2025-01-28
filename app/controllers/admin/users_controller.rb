class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  private

  def authenticate_admin!
    return if current_user&.ADMIN?

    redirect_to root_path, alert: 'No tienes permiso para acceder a esta sección.'
  end
end
