class HomeController < ApplicationController
  layout :resolve_layout

  def index
    @client = Client.new
    page_view_index = PageView.find_by_title('home_index')
    page_view_index.count += 1
    page_view_index.save
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
