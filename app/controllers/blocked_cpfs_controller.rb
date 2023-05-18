class BlockedCpfsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def create
    blocked_cpf = BlockedCpf.new(blocked_cpf_params)
    if blocked_cpf.save
      redirect_to users_path, notice: 'CPF bloqueado com sucesso.'
    else
      redirect_to users_path, alert: 'Digite um CPF válido para bloquear.'
    end
  end

  def destroy
    blocked_cpf = BlockedCpf.find(params[:id])
    if blocked_cpf.destroy
      flash[:notice] = "CPF #{blocked_cpf.cpf} desbloqueado com sucesso!"
    else
      flash[:error] = "Erro ao desbloquear o CPF!"
    end
    redirect_to users_path
  end

  private
  

  def blocked_cpf_params
    params.require(:blocked_cpf).permit(:cpf)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Acesso negado.' unless current_user.admin?
  end
end
