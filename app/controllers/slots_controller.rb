class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy]
  before_action :check_role, except: [:index]
  skip_before_action :verify_authenticity_token  

  # GET /slots
  # GET /slots.json
  def index
   @doc_id = Doctor.where(:user_id => current_user.id)
   @slots = Slot.where(:doctor_id => @doc_id.ids.first)
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @slot = Slot.new
    @hospitals = Hospital.all.collect{|i| [i.name , i.id]}
    @dates = Slot.populateDates
  end

  # GET /slots/1/edit
  def edit
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(slot_params)
    @doc_id = Doctor.where(:user_id => current_user.id)
    @hospitals = Hospital.all.collect{|i| [i.name , i.id]}
    @slot.doctor_id = @doc_id.ids.first
    @dates = Slot.populateDates
    respond_to do |format|
      if @slot.save
        @isSetSlot = Slot.setSlot @slot
        if(@isSetSlot == true)
          format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
          format.json { render :show, status: :created, location: @slot }
        else
          Slot.slotRollBack
          format.html { render :new }
          format.json { render json: @slot.errors, status: :unprocessable_entity }
        end
        
      else
        format.html { render :new }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1
  # PATCH/PUT /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slot_params
      params.require(:slot).permit( :hospital_id, :date, :time_in, :time_out, :no_of_patients)
    end
    def check_role
      if current_user.role =="doctor"
        return true
      else
        redirect_to errors_accesserror_path
      end
   end
end