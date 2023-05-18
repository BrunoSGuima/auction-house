class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :role])
  end

  def authorize_admin
    if current_user == nil
      redirect_to root_path, alert: "Permissão negada"
    elsif current_user.role != "admin"
      redirect_to root_path, alert: "Permissão negada"
    end
  end

  def after_sign_in_path_for(resource)
    if resource.cpf_blocked?
      flash[:alert] = 'Sua conta está suspensa.'
    end
    super
  end
end

