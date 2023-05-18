class UsersController < ApplicationController
  before_action :find_user, only: [:block, :unblock, :block_cpf]
  before_action :authorize_admin

  def index
    @users = User.where.not(role: :admin)
  end

  def block_cpf
    blocked_cpf = BlockedCpf.create(cpf: @user.cpf, user_id: @user.id)
    if blocked_cpf.save
      redirect_to users_path, notice: 'CPF bloqueado com sucesso.'
    else
      redirect_to users_path, alert: 'CPF já foi bloqueado.'
    end
  end
  
  def block
    @user.block!
    redirect_to users_path, alert: 'Usuário foi bloqueado.'
  end

  def unblock
    @user.unblock!
    redirect_to users_path, notice: 'As restrições de acesso foram removidas.'
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
