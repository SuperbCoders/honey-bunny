# encoding: UTF-8
class Cabinet::ProfileController < Cabinet::BaseController

  before_action :find_resource
  before_action :fixparams!, only: %w(update_password)

  def after_save_redirect_action
    :show
  end

  def update
    if @resource.update_attributes(wholesaler_params)
      flash[:success] = 'Изменения сохранены'
    else
      flash[:danger] = 'Изменения не сохранены'
    end

    redirect_to action: after_save_redirect_action
  end

  def update_password
    current_password = params[:wholesaler].delete(:current_password)

    if @resource.valid_password? current_password
      if @resource.update_attributes(wholesaler_params)
        sign_in @resource, bypass:  true
        flash[:success] = 'Изменения сохранены'
        redirect_to action: after_save_redirect_action
      else
        render after_save_redirect_action
      end
    else
      flash[:danger] = 'Неверный текущий пароль'
      render after_save_redirect_action
    end
  end

  private

  def find_resource
    @resource = current_wholesaler
  end

  def fixparams!
    if params[:wholesaler][:password].blank? && params[:wholesaler][:password_confirmation].blank?
      params[:wholesaler].delete(:password)
      params[:wholesaler].delete(:password_confirmation)
    end
  end

  def wholesaler_params
    params.require(:wholesaler).permit(:email, :password, :password_confirmation, :current_password, company_attributes: [:name, :address, :site, :inn, :kpp, :ogrn, :okpo, :bank_details])
  end
end
