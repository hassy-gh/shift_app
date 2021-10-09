class FixedShiftsController < ApplicationController
  
  def index
    @fixed_shifts = FixedShift.all
  end
  
  def new
    @day = params[:format]
    @fixed_shift = FixedShift.new
  end
  
  def create
    @fixed_shift = FixedShift.new(fixed_shift_params)
    if @fixed_shift.save
      flash[:success] = "登録しました"
      redirect_to fixed_shifts_path
    else
      @hope_shifts = HopeShift.where(start_time: params[:fixed_shift][:start_time])
      render 'new'
    end
  end
  
  def edit
    @fixed_shift = FixedShift.find(params[:id])
  end
  
  def update
    @fixed_shift = FixedShift.find(params[:id])
    if @fixed_shift.update(fixed_shift_params)
      flash[:success] = "変更しました"
      redirect_to fixed_shifts_path
    else
      render 'edit'
    end
  end
  
  private
  
    def fixed_shift_params
      params.require(:fixed_shift).permit(:start_time, :fixed_start_time, :fixed_end_time)
    end
end
