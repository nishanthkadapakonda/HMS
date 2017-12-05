class BookingsController < ApplicationController
  def index
  end
  def book
    k = 0
    @available_slots = []
    @booking=Booking.new
    @slot=Slot.find(params[:name])
     #@available_slots = Interval.where(:slot_id => @slot.id)
      @available_slots = Interval.where(:slot_id => @slot.id).where.not(:is_available => false).collect{|i| [i.timeslot , i.id]}
  end
  def createBooking
    @booking=Booking.new(booking_params)
    @booking.hospital_id = Slot.where(:id => @booking.slot_id).first.hospital.id
    @booking.doctor_id = Slot.where(:id => @booking.slot_id).first.doctor.id
    @booking.user_id = current_user.id
    if @booking.save
      @updateColumn = Booking.update_is_available_to_true @booking
      byebug
      @updateSlot = @updateColumn[0]
      @updateInterval = @updateColumn[1]
      @updateInterval.save
      @updateSlot.save
      redirect_to home_mybookings_path
    else
      redirect_to root_path 

    end
  end
  private
  def booking_params
    params.require(:booking).permit(:illness, :symptoms, :slot_id , :slot_time)
  end
end
