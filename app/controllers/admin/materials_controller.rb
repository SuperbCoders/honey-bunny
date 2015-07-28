class Admin::MaterialsController < Admin::ApplicationController
  load_and_authorize_resource param_method: :material_params

  def index
    @materials = Material.all.order(id: :asc)
  end

  def new
  end

  def create
    if @material.save
      redirect_to admin_materials_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @material.update_attributes(material_params)
      redirect_to admin_materials_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  def destroy
    @material.destroy
    redirect_to admin_materials_url, notice: I18n.t('shared.destroyed')
  end

  private

  def material_params
    params.require(:material).permit(:title, :file)
  end

end
