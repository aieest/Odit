class ApplicationController < ActionController::Base
  before_action :redirect_based_on_auth

  private

  def redirect_based_on_auth
    if user_signed_in?
      redirect_to home_path unless current_page?(home_path)
    else
      redirect_to guest_path unless current_page?(guest_path)
    end
  end
end