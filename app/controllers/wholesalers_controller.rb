class WholesalersController < ApplicationController
  layout 'item'

  # GET /wholesalers/new
  def new
    @wholesaler = Wholesaler.new
    @wholesaler.build_company unless @wholesaler.company
  end

  # POST /wholesalers
  def create
    @wholesaler = Wholesaler.new(wholesaler_params)
    if @wholesaler.save
      sign_in @wholesaler
      # redirect_to new_wholesale_order_url
      render text: 'Registered'
    else
      @wholesaler.build_company unless @wholesaler.company
      render :new
    end
  end

  private

    def wholesaler_params
      params.require(:wholesaler).permit(:email, :password, :password_confirmation, company_attributes: [:name, :address, :inn, :kpp, :ogrn, :okpo, :bank_details])
    end
end
