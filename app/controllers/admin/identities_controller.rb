class Admin::IdentitiesController < SuperbAuth::IdentitiesController
  before_action { authorize! :access, :admin_panel }

  protected

    def redirect_after_destroy_success
      redirect_to edit_admin_user_url(current_user), notice: "Привязка к #{params[:provider]} удалена"
    end

    def redirect_after_destroy_fail
      redirect_to edit_admin_user_url(current_user), alert: "Не удалось удалить привязку к #{params[:provider]}"
    end

    def redirect_after_could_not_be_destroyed
      redirect_to edit_admin_user_url(current_user), alert: "Чтобы удалить привязку к #{params[:provider]}, укажите email и пароль, либо привяжите другую социальную сеть"
    end

end
