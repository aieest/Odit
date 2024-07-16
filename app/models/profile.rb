class Profile < ApplicationRecord
  belongs_to :user

  mount_uploader :profile_picture, ProfilePictureUploader
  
  validates :given_name, :last_name, presence: true
  validates :gender, inclusion: { in: ['Male', 'Female'] }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
