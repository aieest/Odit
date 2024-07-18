class EarningsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_earning, only: [:show, :edit, :update, :destroy]

  def index
    @filter = params[:filter] || 'all'
    @earnings = filter_earnings(@filter)
    @total = @earnings.sum(:value)
  end

  def show
  end

  def new
    @earning = @profile.earnings.build
  end

  def create
    @earning = @profile.earnings.build(earning_params)
    if @earning.save
      redirect_to profile_earning_path(@profile, @earning), notice: 'Earning was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @earning.update(earning_params)
      redirect_to profile_earning_path(@profile, @earning), notice: 'Earning was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @earning.destroy
    redirect_to profile_earnings_path(@profile), notice: 'Earning was successfully destroyed.'
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def set_earning
    @earning = @profile.earnings.find(params[:id])
  end

  def earning_params
    params.require(:earning).permit(:title, :value, :interval)
  end

  def filter_earnings(filter)
    case filter
    when 'daily'
      @profile.earnings.where('DATE(interval) = ?', Date.today)
    when 'monthly'
      @profile.earnings.where('EXTRACT(YEAR FROM interval) = ? AND EXTRACT(MONTH FROM interval) = ?', Date.today.year, Date.today.month)
    when 'yearly'
      @profile.earnings.where('EXTRACT(YEAR FROM interval) = ?', Date.today.year)
    else
      @profile.earnings
    end
  end
end