require 'rails_helper'

RSpec.describe 'surgery show page', type: :feature do
  describe 'as a visitor' do
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

    it 'has surgery title and op room number' do
      visit surgery_path(@surgery_1)
      
      expect(page).to have_content(@surgery_1.title)
      expect(page).to have_content(@surgery_1.operating_room)
    end
  end
end