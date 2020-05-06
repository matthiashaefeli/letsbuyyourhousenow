class PageViewResultsController < ApplicationController
  layout 'client'
  before_action :authorization

  def index
    @page_view_results = PageViewResult.last(10)
  end

  private

  def authorization
    unless current_user && current_user.active && current_user.admin
      redirect_to root_path
    end
  end
end
