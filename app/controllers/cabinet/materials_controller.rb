class Cabinet::MaterialsController < Cabinet::BaseController
  before_action :find_resources, only: %w(index)
  before_action :find_resource, only: %w(show)

  def index
  end

  def show
    send_file @resource.file.path, filename: [@resource.title, @resource.file.file.extension].join('.')
  end

  private

  def find_resources
    @resources = Material.all.order(id: :asc)
  end

  def find_resource
    @resource = Material.find(params[:id])
  end
end
