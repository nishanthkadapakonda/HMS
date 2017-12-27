class Doctor < ApplicationRecord
  belongs_to :user
  has_many :slots
  has_many :hospitals, through: :slots
  delegate :name,:phone, to: :user, prefix: "user"
  
end
