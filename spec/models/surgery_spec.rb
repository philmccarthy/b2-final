require 'rails_helper'

RSpec.describe Surgery, type: :model do
  describe 'relationships' do
    it { should have_many :doctor_surgeries }
    it { should have_many(:doctors).through(:doctor_surgeries) }
  end

  describe 'model methods' do
    before(:each) do
      @hospital_1 = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
      @doctor_1 = @hospital_1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', alma_mater: 'Harvard University')
      @doctor_2 = @hospital_1.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', alma_mater: 'Johns Hopkins University')
      @doctor_3 = @hospital_1.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', alma_mater: 'Stanford University')
      @doctor_4 = @hospital_1.doctors.create!(name: 'Derek McDreamy Shepherd', specialty: 'Attending Surgeon', alma_mater: 'University of Pennsylvania')
      
      @surgery_1 = Surgery.create!(title: 'Brain Surgery', day: 'Monday', operating_room: 1)
      DoctorSurgery.create!(doctor: @doctor_1, surgery: @surgery_1)
      DoctorSurgery.create!(doctor: @doctor_2, surgery: @surgery_1)
      DoctorSurgery.create!(doctor: @doctor_3, surgery: @surgery_1)
      DoctorSurgery.create!(doctor: @doctor_4, surgery: @surgery_1)
      
      @surgery_2 = Surgery.create!(title: 'Open Heart Surgery', day: 'Monday', operating_room: 2)
      DoctorSurgery.create!(doctor: @doctor_2, surgery: @surgery_2)
      DoctorSurgery.create!(doctor: @doctor_3, surgery: @surgery_2)
    end

    describe 'instance methods' do
      it '#same_day_surgeries' do

        expect(@surgery_1.same_day_surgeries).to eq([@surgery_2])
        
        surgery_3 = Surgery.create!(title: 'ANOTHER Brain Surgery?', day: 'Monday', operating_room: 3)
        surgery_4 = Surgery.create!(title: 'ANOTHER Another Brain Surgery?', day: 'Monday', operating_room: 4)
        
        expect(@surgery_1.same_day_surgeries).to eq([@surgery_2, surgery_3, surgery_4])
      end
    end
  end
end
