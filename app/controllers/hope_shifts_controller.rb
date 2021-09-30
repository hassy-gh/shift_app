class HopeShiftsController < ApplicationController
  
  def new
    @hope_shift = current_user.hope_shifts.build
    @day = params[:format]
  end
  
  def create
    @hope_shift = current_user.hope_shifts.build(hope_shift_params)
    if @hope_shift.save
      flash[:success] = "登録しました"
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
