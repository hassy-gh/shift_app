class HopeShiftsController < ApplicationController
  before_action :logged_in_user
  before_action :no_join_user
  before_action :get_group, only: [:new, :create]
  before_action :get_hope_shift, only: [:edit, :update, :correct_user]
  before_action :correct_user, only: [:edit, :update]

  def index
    @hope_shifts = current_user.hope_shifts.all
  end
  
  def new
    @day = params[:format]
    @hope_shift = current_user.hope_shifts.build
  end
  
  def create
    @hope_shift = current_user.hope_shifts.build(hope_shift_params)
    if @hope_shift.save
      flash[:success] = "登録しました"
      redirect_to hope_shifts_path
    else
      @day = params[:hope_shift][:start_time]
      render 'new'
    end
  end
  
  def edit
    @day = @hope_shift.start_time
  end
  
  def update
    if @hope_shift.update(hope_shift_params)
      flash[:success] = "変更しました"
      redirect_to hope_shifts_path
    else
      @day = @hope_shift.start_time
      render 'edit'
    end
  end
  
  private
  
    def hope_shift_params
      params.require(:hope_shift).permit(:content, :start_time, :hope_start_time, :hope_end_time)
    end
    
    # beforeアクション
    
    # 正しいユーザーか確認
    def correct_user
      unless current_user.id == @hope_shift.user.id
        flash[:danger] = "正しいユーザーではありません"
        redirect_to(current_user)
      end
    end
end
