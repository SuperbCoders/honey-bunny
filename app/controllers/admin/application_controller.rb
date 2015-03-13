class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action { authorize! :access, :admin_panel }
  layout 'admin'

  def new_orders_count
    @new_orders_count ||= Order.with_new_state.count
  end
  helper_method :new_orders_count

  def new_questions_count
    @new_questions_count ||= Question.with_new_state.count
  end
  helper_method :new_questions_count
end
