class ApplicationController < ActionController::Base
  before_action :redirect_based_on_auth, unless: :devise_controller?

  private

  def redirect_based_on_auth
    if user_signed_in?
      redirect_to home_path unless request.path == home_path
    else
      redirect_to guest_path unless request.path == guest_path
    end
  end
end