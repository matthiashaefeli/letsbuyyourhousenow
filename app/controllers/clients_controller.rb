class ClientsController < ApplicationController
  def index
    @clients = Client.where(active: true)
  end
  
  def new
    @client = Client.new
  end

  def create
    client = Client.new(client_params)
    if client.valid?
      client.save
      render text: 'saved'
    else
      errors = client.errors.full_messages
      render json: { error: errors }
    end
  end

  private

  def client_params
    params.require(:client).permit(:first_name, :last_name, :tel, :address, :email, :city, :state, :zip)
  end
end
