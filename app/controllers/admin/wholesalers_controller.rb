class Admin::WholesalersController < Admin::ApplicationController
  include WorkflowController
  workflow_events :approve, :decline

  load_and_authorize_resource param_method: :wholesaler_params

  # GET /admin/wholesalers
  def index
    @wholesalers = @wholesalers.includes(:company)
    workflow_state = params[:workflow_state].present? ? params[:workflow_state] : 'new'
    @wholesalers = @wholesalers.where(workflow_state: workflow_state)
    @wholesalers = @wholesalers.where('LOWER(name) LIKE ?', "%#{params[:name].mb_chars.downcase.to_s}%") if params[:name].present?
    @wholesalers = @wholesalers.where('LOWER(email) LIKE ?', "%#{params[:email].mb_chars.downcase.to_s}%") if params[:email].present?
    @wholesalers = @wholesalers.page(params[:page]).per(50)
  end

  # GET /admin/wholesalers/new
  def new
  end

  # POST /admin/wholesalers
  def create
    if @wholesaler.save
      redirect_to admin_wholesalers_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/wholesalers/:id/edit
  def edit
    cookies[:omniauth_redirect_url] = edit_admin_wholesaler_url(@wholesaler)
  end

  # PUT/PATCH /admin/wholesalers/:id
  def update
    account_update_params = wholesaler_params
    account_update_params.delete('password') if account_update_params[:password].blank?
    if @wholesaler.update_attributes(account_update_params)
      redirect_to admin_wholesalers_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/wholesalers/:id
  def destroy
    if @wholesaler.id != current_wholesaler.id && @wholesaler.destroy
      redirect_to admin_wholesalers_url, notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_wholesalers_url, alert: I18n.t('shared.not_destroyed')
    end
  end

  private

    def wholesaler_params
      params.require(:wholesaler).permit(:email, :password, :password_confirmation, company_attributes: [:name, :address, :inn, :kpp, :ogrn, :okpo, :bank_details])
    end
end
