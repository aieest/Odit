class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_based_on_auth, except: [:new, :create, :edit, :update, :edit_balance, :update_balance]
  before_action :set_profile, only: [:show, :edit, :update, :edit_balance, :update_balance]

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
      redirect_to home_path, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to home_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def edit_balance
  end

  def update_balance
    if @profile.update(balance: params[:profile][:balance])
      redirect_to settings_path, notice: 'Balance was successfully updated.'
    else
      render :edit_balance
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

  def redirect_based_on_auth
    if user_signed_in?
      allowed_paths = [
        home_path, 
        profile_path(current_user.profile), 
        new_profile_path, 
        edit_profile_path(current_user.profile), 
        edit_balance_profile_path(current_user.profile)
      ]
      redirect_to home_path unless allowed_paths.include?(request.path)
    else
      redirect_to guest_path unless request.path == guest_path
    end
  end
end