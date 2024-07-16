class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def new
    if current_user.profile
      redirect_to edit_profile_path(current_user.profile)
    else
      @profile = current_user.build_profile
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.profile
    redirect_to new_profile_path unless @profile
  end

  def profile_params
    params.require(:profile).permit(:given_name, :last_name, :gender, :profile_picture, :balance)
  end
end
