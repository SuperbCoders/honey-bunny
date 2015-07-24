class WholesalersController < ApplicationController
  layout 'wholesalers'

  # GET /wholesalers/new
  def new
    @wholesaler = Wholesaler.new
    @wholesaler.build_company unless @wholesaler.company
  end

  # POST /wholesalers
  def create
    @wholesaler = Wholesaler.new(wholesaler_params)
    if @wholesaler.save
      User.admins.where(notify_about_wholesalers: true).pluck(:email).select(&:present?).each do |email|
        WholesalerMailer.notify_admin(@wholesaler.id, email).deliver!
      end
      sign_in @wholesaler
      redirect_to new_wholesale_order_url
    else
      @wholesaler.build_company unless @wholesaler.company
      render :new
    end
  end

  # GET /wholesalers/select
  def select
    new
  end

  # GET /wholesalers/pending
  def pending
    render layout: 'simple'
  end

  private

  def wholesaler_params
    params.require(:wholesaler).permit(:email, :password, :password_confirmation, company_attributes: [:name, :address, :site, :inn, :kpp, :ogrn, :okpo, :bank_details])
  end
end
