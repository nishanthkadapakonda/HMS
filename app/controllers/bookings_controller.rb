class BookingsController < ApplicationController
  def index
  end
  def book
    @booking=Booking.new
    @slot=Slot.find(params[:name])
  end
  def createBooking
    @booking=Booking.new(booking_params)
    byebug
    @booking.hospital_id = Slot.where(:id => @booking.slot_id).first.hospital.id
    @booking.doctor_id = Slot.where(:id => @booking.slot_id).first.doctor.id
    @booking.user_id = current_user.id
    byebug
    if @booking.save
      @updateSlot = Slot.where(:id => @booking.slot_id).first
      @updateSlot.no_of_patients = @updateSlot.no_of_patients - 1
      @updateSlot.save
      redirect_to home_mybookings_path
    else
      redirect_to root_path 

    end
  end
  private
  def booking_params
    params.require(:booking).permit(:illness, :symptoms, :slot_id)
  end
end
