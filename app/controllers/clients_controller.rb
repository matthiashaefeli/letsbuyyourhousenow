class ClientsController < ApplicationController
  layout 'client'
  before_action :authorization, except: :create

  def index
    @clients = Client.where(status: 'New')
  end

  def client_entries
    @clients = Client.where(status: params[:status])
    render partial: 'clientTable'
  end

  def new
    @client = Client.new
    render layout: false
  end

  def create
    client = Client.new(client_params)
    if client.valid?
      client.save
      ClientMailer.with(client: client).new_client_email.deliver_later
      ClientMailer.with(client: client).welcome_client.deliver_later
      render json: { message: 'saved' }
    else
      errors = client.errors.full_messages
      render json: { error: errors }
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def edit
    @client = Client.find(params[:id])
    render layout: false
  end

  def update
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @client.update_attributes(edit_client_params)
      render 'show', layout: false and return
    elsif params[:id]
      client = Client.find(params[:id])

      redirect_to client_show_images_path(client.id, error_message: 'Error: Please select a Image!') and return if params[:client_images].nil?

      params[:client_images][:images].each do |image|
        redirect_to client_show_images_path(client.id, error_message: 'Error: Image to Big!') and return if image.size/1000 > 2000

        client.images.attach(image)
        client.save
      end
      redirect_to client_show_images_path(client.id, success_message: 'Success: The Images are up!')
    end

  end

  def destroy
    client = Client.find(params[:id])
    client.delete
    redirect_to clients_path
  end

  def show_images
    @error_message = params[:error_message].nil? ? nil : params[:error_message]
    @success_message = params[:success_message].nil? ? nil : params[:success_message]
    @client = Client.find(params[:id])
  end

  def delete_image
    client = Client.find(params[:client_id])
    client.images.find(params[:id]).purge
    redirect_to client_show_images_path(client.id, success_message: 'Success: The Image was removed!')
  end

  def show_image
    binding.pry
  end

  private

  def authorization
    unless current_user && current_user.active && current_user.admin
      redirect_to root_path
    end
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip)
  end

  def edit_client_params
    params.require(:editclient).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip, :comments, :offer, :price, :status, :new)
  end
end
