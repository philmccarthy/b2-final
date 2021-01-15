# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Hospital.destroy_all
Doctor.destroy_all
Surgery.destroy_all
DoctorSurgery.destroy_all

@hospital_1 = Hospital.create!(name: 'Grey Sloan Memorial Hospital')
@doctor_1 = @hospital_1.doctors.create!(name: 'Meredith Grey', specialty: 'General Surgery', alma_mater: 'Harvard University')
@doctor_2 = @hospital_1.doctors.create!(name: 'Alex Karev', specialty: 'Pediatric Surgery', alma_mater: 'Johns Hopkins University')

@hospital_2 = Hospital.create!(name: 'Seaside Health & Wellness Center')
@doctor_3 = @hospital_2.doctors.create!(name: 'Miranda Bailey', specialty: 'General Surgery', alma_mater: 'Stanford University')
@doctor_4 = @hospital_2.doctors.create!(name: 'Derek McDreamy Shepherd', specialty: 'Attending Surgeon', alma_mater: 'University of Pennsylvania')

@surgery_1 = Surgery.create!(title: 'Brain Surgery', day: 'Monday', operating_room: 1)
@surgery_2 = Surgery.create!(title: 'Tommy Johns Surgery', day: 'Monday', operating_room: 2)
@surgery_3 = Surgery.create!(title: 'Wrist Surgery', day: 'Wednesday', operating_room: 1)
@surgery_4 = Surgery.create!(title: 'Open Heart Surgery', day: 'Thursday', operating_room: 3)

DoctorSurgery.create!(doctor: @doctor_1, surgery: @surgery_1)
DoctorSurgery.create!(doctor: @doctor_1, surgery: @surgery_2)
DoctorSurgery.create!(doctor: @doctor_1, surgery: @surgery_3)
DoctorSurgery.create!(doctor: @doctor_1, surgery: @surgery_4)

DoctorSurgery.create!(doctor: @doctor_2, surgery: @surgery_2)
DoctorSurgery.create!(doctor: @doctor_2, surgery: @surgery_3)

DoctorSurgery.create!(doctor: @doctor_3, surgery: @surgery_3)
DoctorSurgery.create!(doctor: @doctor_3, surgery: @surgery_4)

DoctorSurgery.create!(doctor: @doctor_4, surgery: @surgery_1)
DoctorSurgery.create!(doctor: @doctor_4, surgery: @surgery_3)
DoctorSurgery.create!(doctor: @doctor_4, surgery: @surgery_4)