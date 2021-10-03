class HopeShiftsController < ApplicationController
  
  def new
    @day = params[:format]
    @hope_shift = current_user.hope_shifts.build
    @hope_shifts = HopeShift.where(start_time: params[:format])
  end
  
  def create
    @hope_shift = current_user.hope_shifts.build(hope_shift_params)
    if @hope_shift.save
      flash[:success] = "登録しました"
      redirect_to current_user
    else
      @hope_shifts = HopeShift.where(start_time: params[:hope_shift][:start_time])
      render 'new'
    end
  end
  
  def edit
    @hope_shift = HopeShift.find(params[:id])
  end
  
  def update
    @hope_shift = HopeShift.find(params[:id])
    if @hope_shift.update(hope_shift_params)
      flash[:success] = "変更しました"
      redirect_to current_user
    else
      render 'edit'
    end
  end
  
  private
  
    def hope_shift_params
      params.require(:hope_shift).permit(:content, :start_time)
    end
end
