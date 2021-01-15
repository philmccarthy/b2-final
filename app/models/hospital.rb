class Hospital < ApplicationRecord
  has_many :doctors
  has_many :doctor_surgeries, through: :doctors
  has_many :surgeries, through: :doctor_surgeries
end
