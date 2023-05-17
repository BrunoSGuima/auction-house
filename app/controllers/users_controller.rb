class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:block, :unblock]
  before_action :authorize_admin, only: [:block, :unblock]

  def index
    @users = User.where.not(role: :admin)
  end
  

  def block
    @user.block!
    redirect_to users_path, notice: 'Usuário foi bloqueado.'
  end

  def unblock
    @user.unblock!
    redirect_to users_path, notice: 'Usuário foi desbloqueado.'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'Acesso negado.' unless current_user.admin?
  end
end
