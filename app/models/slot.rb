class Slot < ApplicationRecord
  belongs_to :doctor
  belongs_to :hospital
end
