class ResourcesController < ApplicationController
  layout 'client'
  before_action :authorization

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
    render layout: false
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.valid?
      @resource.save
      render layout: false
    else
      render json: { error: @resource.errors.full_messages }
    end
  end

  def destroy
    resource = Resource.find(params[:id])
    resource.delete
    render json: { message: 'deleted' }
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :url)
  end

  def authorization
    unless current_user && current_user.active && current_user.admin
      redirect_to root_path
    end
  end
end
