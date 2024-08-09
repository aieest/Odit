class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @profile = current_user.profile
  end
end
  