class Slot < ApplicationRecord
  belongs_to :doctor
  belongs_to :hospital
  def self.slotRollBack
    raise ActiveRecord::Rollback
  end
  def self.setSlot slot
    flag = 0
    @total_slot_time = slot.time_out.to_time - slot.time_in.to_time
    @no_of_intervals = (@total_slot_time/15.minutes).round
    @temp=slot.time_in.to_time
    (@no_of_intervals).times do |s|
      @interval = Interval.new
      @interval.slot_id = slot.id
      if(s == 0)
        @time = @temp.to_time
      else
        @time = @temp.to_time + 15.minutes
      end
      @interval.timeslot = @time.strftime("%I:%M%p")
      @temp=@interval.timeslot
        if @interval.save
           flag = flag+1
        else
           flag = 0
        end
    end
    if flag < @no_of_intervals
      return false
    else
      return true
    end
  end

  def self.populateDates
    @dates =[Date.today,Date.today+1,Date.today+2,Date.today+3,Date.today+4]
    return @dates
  end
end
