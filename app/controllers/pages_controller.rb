class PagesController < ApplicationController
  skip_before_action :redirect_based_on_auth, only: [:home, :guest]

  def home
    redirect_to guest_path unless user_signed_in?
  end

  def guest
    redirect_to home_path if user_signed_in?
  end
end
