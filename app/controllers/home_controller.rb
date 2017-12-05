class HomeController < ApplicationController
  before_action :authenticate_user!
 before_action :check_role
 skip_before_action :verify_authenticity_token  
 
  def index
    @slot = Slot.new
    @doctors = Doctor.all
    @hospitals = Hospital.all
    if(params[:selectedType] == "doctor")
      @slots=[]
      @d_id = []
      @u_id = User.where(:name=>params[:browser],:role => "doctor")
      i = 0
      @u_id.each do |u|
        @d_id[i] = Doctor.where(:user_id => u.id) 
        i = i+1       
      end
      i = 0
      @d_id.each do |u|
        @slots[i] = Slot.where(:doctor_id => u.ids)    
        i =i+1
      end
    end
    if(params[:selectedType] == "specialization")
      @slots=[]
      @u_id = Doctor.where(:specialization=>params[:browser])
      i=0
      @u_id.each do |u|
        @slots[i] = Slot.where(:doctor_id => u.id)
        i =i+1
      end
    end
    if(params[:selectedType] == "hospital")
      @flag ="hospital"
      @slots=[]
      @u_id = Hospital.where(:name=>params[:browser])
      @slots= Slot.where(:hospital_id => @u_id.ids)
    end
  end
  def mybookings
    if(current_user.role == 'patient')
      @bookings=Booking.where(:user_id =>current_user.id)
      @timing = []
      i = 0
      @bookings.each do |b|
        @timing[i] = Interval.where(:id => b.slot_time)
        i = i+1
      end
    elsif(current_user.role == 'admin')
      @bookings=Booking.all
    end
  end

  private
  def check_role
    if current_user.role == "patient" || current_user.role == "admin"
      return true
    else
      redirect_to errors_accesserror_path
    end
 end
end