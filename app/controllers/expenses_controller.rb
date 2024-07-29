class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @filter = params[:filter] || 'all'
    @expenses = filter_expenses(@filter)
    @total = @expenses.sum(:value)
  end

  def show
  end

  def new
    @expense = @profile.expenses.build
  end

  def create
    @expense = @profile.expenses.build(expense_params)
    if @expense.save
      redirect_to profile_expense_path(@profile, @expense), notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      redirect_to profile_expense_path(@profile, @expense), notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to profile_expenses_path(@profile), notice: 'Expense was successfully deleted.'
  end

  private

  def set_profile
    @profile = current_user.profile
    redirect_to new_profile_path, alert: 'Please create a profile first.' unless @profile
  end

  def set_expense
    @expense = @profile.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :value, :interval)
  end

  def filter_expenses(filter)
    case filter
    when 'daily'
      @profile.expenses.where('date(interval) = ?', Date.today.to_s)
    when 'monthly'
      start_of_month = Date.today.beginning_of_month
      end_of_month = Date.today.end_of_month
      @profile.expenses.where('date(interval) BETWEEN ? AND ?', start_of_month, end_of_month)
    when 'yearly'
      start_of_year = Date.today.beginning_of_year
      end_of_year = Date.today.end_of_year
      @profile.expenses.where('date(interval) BETWEEN ? AND ?', start_of_year, end_of_year)
    else
      @profile.expenses
    end
  end
end