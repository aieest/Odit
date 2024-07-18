class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  private

  def redirect_based_on_auth
    if user_signed_in? && !current_page?(home_path) && !current_page?(profile_path(current_user.profile)) && !current_page?(new_profile_path) && !current_page?(edit_profile_path(current_user.profile))
      redirect_to home_path
    elsif !user_signed_in? && !current_page?(guest_path)
      redirect_to guest_path
    end
  end
end