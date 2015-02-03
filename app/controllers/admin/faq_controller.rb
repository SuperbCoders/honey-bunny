class Admin::FAQController < Admin::ApplicationController
  load_and_authorize_resource param_method: :faq_params
  before_action :set_faq, only: [:up, :down]

  # GET /admin/faq
  def index
    @faqs = @faqs.order(id: :asc)
  end

  # GET /admin/faq/new
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

  # GET /admin/faq/:id/edit
  def edit
  end

  # PATCH/PUT /admin/faq/:id
  def update
    if @faq.update_attributes(faq_params)
      redirect_to admin_faqs_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/faq/:id
  def destroy
    @faq.destroy
    redirect_to admin_faqs_url, notice: I18n.t('shared.destroyed')
  end

  # POST /admin/faq/:id/up
  def up
    @faq.up
    redirect_to admin_faqs_url, notice: I18n.t('shared.saved')
  end

  # POST /admin/faq/:id/down
  def down
    @faq.down
    redirect_to admin_faqs_url, notice: I18n.t('shared.saved')
  end

  private

    def faq_params
      params.require(:faq).permit(:question, :answer)
    end

    def set_faq
      @faq = FAQ.find(params[:id])
    end

end
