class ClientsController < ApplicationController
  def index
    @clients = Client.where(active: true)
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
    @client = Client.find(params[:id])
    @client.update_attributes(client_params)
    render 'show', layout: false
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip, :comments, :offer, :price, :status, :new)
  end
end
