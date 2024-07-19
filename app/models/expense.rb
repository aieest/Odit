class Expense < ApplicationRecord
  belongs_to :profile

  validates :title, presence: true
  validates :value, numericality: { greater_than: 0 }
  validates :interval, presence: true
end