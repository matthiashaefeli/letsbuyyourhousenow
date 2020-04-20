class ClientsController < ApplicationController
  layout 'client'

  def index
    @clients = Client.where(status: @status)
  end

  def clients
    binding.pry
  end

  def new
    @client = Client.new
    render layout: false
  end

  def create
    client = Client.new(client_params)
    if client.valid?
      client.save
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

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip)
  end

  def edit_client_params
    params.require(:editclient).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip, :comments, :offer, :price, :status, :new)
  end
end
