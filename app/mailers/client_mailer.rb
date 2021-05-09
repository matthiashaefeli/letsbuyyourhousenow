class ClientMailer < ApplicationMailer
  def new_client_email
    @client = params[:client]

    mail(to: 'casillasmoraleslaura@gmail.com', subject: 'You got a new Client')
  end

  def welcome_client
    @client = params[:client]

    mail(to: @client.email, subject: 'createforallinvestments.com')
  end
end
