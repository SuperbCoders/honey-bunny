class Cabinet::BaseController < ApplicationController
  layout 'cabinet'
  respond_to :js, :html
  before_action :authenticate_wholesaler!

  private

  def authenticate_wholesaler!
    if current_wholesaler
      redirect_to pending_wholesalers_url unless current_wholesaler.approved?
    else
      redirect_to '/wholesale' #select_wholesalers_url
    end
  end
end
