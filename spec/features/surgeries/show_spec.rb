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
      expect(page).to have_content(@surgery_1.day)

      visit surgery_path(@surgery_2)
      
      expect(page).to have_content(@surgery_2.title)
      expect(page).to have_content(@surgery_2.operating_room)
      expect(page).to have_content(@surgery_2.day)
    end

    it 'has a section listing titles of other surgeries happening the same day' do
      surgery_3 = Surgery.create!(title: 'ANOTHER Brain Surgery?', day: 'Tuesday', operating_room: 3)
      surgery_4 = Surgery.create!(title: 'ANOTHER Another Brain Surgery?', day: 'Tuesday', operating_room: 4)

      visit surgery_path(@surgery_1)
      
      within('#same-day-surgeries') do
        expect(page).to have_content(@surgery_2.title)
        expect(page).to_not have_content(surgery_3.title)
        expect(page).to_not have_content(surgery_4.title)
      end

      surgery_3.update!(day: 'Monday')
      surgery_4.update!(day: 'Monday')

      visit surgery_path(@surgery_1)

      within('#same-day-surgeries') do
        expect(page).to have_content(@surgery_2.title)
        expect(page).to have_content(surgery_3.title)
        expect(page).to have_content(surgery_4.title)
      end
    end

    it 'i can search by partial name to add existing doctors to the surgery' do
      visit surgery_path(@surgery_2)
        expect(page).to have_content('Add A Doctor To This Surgery')
        expect(page).to_not have_content(@doctor_4.name)
        expect(page).to_not have_content(@doctor_1.name)
        
        fill_in 'Name', with: 'Derek'
        click_button 'Add to Surgery'

        expect(page).to have_content(@doctor_4.name)
        
        fill_in 'Name', with: 'Meredith Grey'
        click_button 'Add to Surgery'

        expect(page).to have_content(@doctor_1.name)
      end
  end
end