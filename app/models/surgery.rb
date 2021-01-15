class Surgery < ApplicationRecord
  has_many :doctor_surgeries
  has_many :doctors, through: :doctor_surgeries

  def same_day_surgeries
    Surgery.where('day = ? AND id != ?', day, id)
  end
end
