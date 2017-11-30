class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role 
  def index
    doc_id=Doctor.where(:user_id=>current_user.id)
    @bookings = Booking.where(:doctor_id => doc_id.first.id)  
  end
  def show
    @booking = Booking.find(params[:id])
  end
  def create
    @booking = Booking.find(params[:bookingId])    
    if  @booking.update_attributes(booking_params)
      redirect_to doctors_index_path
    else
      flash[:error] = "Error in Updating"
      redirect_to root_path
    end
  end
  private
  def booking_params
    params.require(:booking).permit(:observation , :status)
  end
  def check_role
    if current_user.role =="doctor"
      return true
    else
      redirect_to errors_accesserror_path
    end
  end
end
