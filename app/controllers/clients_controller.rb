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
    @client = Client.find(params[:client_id])
    @client.update_attributes(edit_client_params)
    render 'show'
  end

  def destroy
    client = Client.find(params[:id])
    client.delete
    redirect_to clients_path
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