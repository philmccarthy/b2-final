class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_surgeries
  has_many :surgeries, through: :doctor_surgeries

  def self.search_name(name)
    find_by('name LIKE ?', "%#{name}%")
  end
end
