require 'rails_helper'

RSpec.describe Doctor, type: :model do
 describe 'relationships' do
    it { should belong_to :hospital }
    it { should have_many(:doctor_surgeries) }
    it { should have_many(:surgeries).through(:doctor_surgeries) }
  end

  describe 'class methods' do
    it '::search_name()' do
      @hospital_1 = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
      @doctor_1 = @hospital_1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', alma_mater: 'Harvard University')
      @doctor_2 = @hospital_1.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', alma_mater: 'Johns Hopkins University')
      @doctor_3 = @hospital_1.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', alma_mater: 'Stanford University')
      @doctor_4 = @hospital_1.doctors.create!(name: 'Derek McDreamy Shepherd', specialty: 'Attending Surgeon', alma_mater: 'University of Pennsylvania')
      
      expect(Doctor.search_name('Meredith')).to eq(@doctor_1)
      expect(Doctor.search_name('Alex Karev')).to eq(@doctor_2)
      expect(Doctor.search_name('Bailey')).to eq(@doctor_3)
      expect(Doctor.search_name('McDream')).to eq(@doctor_4)
    end
  end
end
