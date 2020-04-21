class HomeController < ApplicationController
  layout :resolve_layout

  def index
    @client = Client.new
  end

  def login
    render template: './devise/sessions/new'
  end

  private

  def resolve_layout
    case action_name
    when 'login'
     'client'
    else
     'application'
    end
  end
end
