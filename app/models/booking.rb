class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  belongs_to :hospital
  belongs_to :doctor
end
