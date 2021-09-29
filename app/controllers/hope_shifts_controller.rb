class HopeShiftsController < ApplicationController
  
  def new
    @hope_shift = HopeShift.new
  end
  
  def create
    @hope_shift = current_user.hope_shifts.build(hope_shift_params)
    if @hope_shift.save
      flash[:success] = "シフト希望を登録しました"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  private
  
    def hope_shift_params
      params.require(:hope_shift).permit(:content, :start_time)
    end
end
