class BookingsController < ApplicationController
  def index
  end
  def book
    k = 0
    @available_slots = []
    @booking=Booking.new
    @slot=Slot.find(params[:name])
     #@available_slots = Interval.where(:slot_id => @slot.id)
      #@available_slots = Interval.where(:slot_id => @slot.id).where.not(:is_available => false).collect{|i| [i.timeslot , i.id]}
      @available_slots = Interval.where(:slot_id => @slot.id).collect{|i| [i.timeslot , i.id, i.is_available]}
  end
  def createBooking
    @booking=Booking.new(booking_params)
    @booking.hospital_id = Slot.where(:id => @booking.slot_id).first.hospital.id
    @booking.doctor_id = Slot.where(:id => @booking.slot_id).first.doctor.id
    @booking.user_id = current_user.id
    if Interval.where(:id => @booking.slot_time.to_i).first.is_available == true
    if @booking.save
      @updateColumn = Booking.update_is_available_to_true @booking
      @updateSlot = @updateColumn[0]
      @updateInterval = @updateColumn[1]
      @updateInterval.save
      if @updateSlot.save
        flash[:success] = "Slot Created Successfully!"
        redirect_to home_mybookings_path
      else
        flash[:success] = "Error in Creating Slot!please try again :("
      end
    else
      redirect_to root_path
    end
  else
    redirect_to bookings_book_path(:name => @booking.slot_id)
    flash[:error] = "slot is not available try with another slot"
  end
  end
  private
  def booking_params
    params.require(:booking).permit(:illness, :symptoms, :slot_id , :slot_time)
  end
end
