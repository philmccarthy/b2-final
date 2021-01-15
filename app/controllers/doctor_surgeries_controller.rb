class DoctorSurgeriesController < ApplicationController
  def create
    doctor = Doctor.search_name(params[:doctor_surgery][:name])
    surgery = Surgery.find(params[:doctor_surgery][:surgery_id])
    DoctorSurgery.create!(doctor: doctor, surgery: surgery)
    redirect_to surgery_path(surgery)
  end
end