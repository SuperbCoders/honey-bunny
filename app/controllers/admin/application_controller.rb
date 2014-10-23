class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action { authorize! :access, :admin_panel }
  layout 'admin'
end
