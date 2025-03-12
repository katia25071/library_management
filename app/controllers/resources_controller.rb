class ResourcesController < ApplicationController
  before_action :set_resource, only: [ :show, :edit, :update, :destroy ]
  before_action :require_library_personnel, except: [ :index, :show ]

  def index
    result = Resources::SearchCommand.execute(search_params)
    @resources = result[:resources]

    respond_to do |format|
      format.html
      format.json { render json: @resources }
      format.xml { render xml: @resources }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @resource }
      format.xml { render xml: @resource }
    end
  end

  def new
    @resource = Resource.new
  end

  def create
    result = Resources::CreateCommand.execute(resource_params)

    if result[:success]
      redirect_to result[:resource], notice: "Resource was successfully created."
    else
      @resource = Resource.new(resource_params)
      @resource.errors.add(:base, result[:errors])
      render :new
    end
  end

  def edit
  end

  def update
    result = Resources::UpdateCommand.execute(@resource, resource_params)

    if result[:success]
      redirect_to result[:resource], notice: "Resource was successfully updated."
    else
      @resource.errors.add(:base, result[:errors])
      render :edit
    end
  end

  def destroy
    result = Resources::DeleteCommand.execute(@resource)

    if result[:success]
      redirect_to resources_path, notice: "Resource was successfully deleted."
    else
      redirect_to resources_path, alert: "Could not delete resource: #{result[:errors].join(', ')}"
    end
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def search_params
    params.permit(:query, :category, :type)
  end

  def resource_params
    params.require(:resource).permit(:title, :publish_year, :language, :publisher,
                                   :description, :type, :author, :volume, :issue,
                                   :category)
  end
end
