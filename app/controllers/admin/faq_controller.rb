class Admin::FAQController < Admin::ApplicationController
  load_and_authorize_resource param_method: :faq_params

  # GET /admin/faqs
  def index
    @faqs = @faqs.order(id: :asc)
  end

  # GET /admin/faqs/new
  def new
  end

  # POST /admin/faqs
  def create
    if @faq.save
      redirect_to admin_faqs_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/faqs/:id/edit
  def edit
  end

  # PATCH/PUT /admin/faqs/:id
  def update
    if @faq.update_attributes(faq_params)
      redirect_to admin_faqs_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/faqs/:id
  def destroy
    @faq.destroy
    redirect_to admin_faqs_url, notice: I18n.t('shared.destroyed')
  end

  private

    def faq_params
      params.require(:faq).permit(:question, :answer)
    end

end
