class Profile < ApplicationRecord
  belongs_to :user
  has_many :earnings
  has_many :expenses

  mount_uploader :profile_picture, ProfilePictureUploader
  
  validates :given_name, :last_name, presence: true
  validates :gender, inclusion: { in: ['Male', 'Female'] }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def complete?
    given_name.present? && last_name.present? && gender.present? && balance.present?
  end

  def total_earnings
    earnings.sum(:value)
  end

  def total_expenses
    expenses.sum(:value)
  end

  def current_balance
    balance + (total_earnings - total_expenses)
  end
end
