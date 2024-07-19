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
    redirect_to profile_expenses_path(@profile), notice: 'Expense was successfully destroyed.'
  end

  private

  def set_profile
    @profile = current_user.profile
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
      @profile.expenses.where('DATE(interval) = ?', Date.today)
    when 'monthly'
      @profile.expenses.where('EXTRACT(YEAR FROM interval) = ? AND EXTRACT(MONTH FROM interval) = ?', Date.today.year, Date.today.month)
    when 'yearly'
      @profile.expenses.where('EXTRACT(YEAR FROM interval) = ?', Date.today.year)
    else
      @profile.expenses
    end
  end
end