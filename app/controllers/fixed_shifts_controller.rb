class FixedShiftsController < ApplicationController
  before_action :get_group, only: [:index, :new, :create, :edit, :update, :day_index]
  before_action :get_fixed_shift, only: [:edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @fixed_shifts = @group.fixed_shifts.all
  end
  
  def new
    @day = params[:format]
    @user = @group.users.find(params[:id]).id
    @fixed_shift = FixedShift.new
  end
  
  def create
    @fixed_shift = FixedShift.new(fixed_shift_params)
    if @fixed_shift.save
      flash[:success] = "登録しました"
      redirect_to day_index_fixed_shifts_path(params[:fixed_shift][:start_time])
    else
      @day = params[:fixed_shift][:start_time]
      @user = params[:fixed_shift][:user_id]
      render "new"
    end
  end
  
  def edit
    @day = @fixed_shift.start_time
    @user = @fixed_shift.user_id
  end
  
  def update
    if @fixed_shift.update(fixed_shift_params)
      flash[:success] = "変更しました"
      redirect_to day_index_fixed_shifts_path(params[:fixed_shift][:start_time])
    else
      @day = @fixed_shift.start_time
      @user = @fixed_shift.user_id
      render 'edit'
    end
  end
  
  def destroy
    @fixed_shift.destroy
    flash[:success] = "削除しました"
    redirect_to day_index_fixed_shifts_path(@fixed_shift.start_time)
  end
  
  def day_index
    @day = params[:format]
    @users = @group.users
    @fixed_shifts = @group.fixed_shifts.where(start_time: @day)
    @hope_shifts = @group.hope_shifts.where(start_time: @day)
  end
  
  private
  
    def fixed_shift_params
      params.require(:fixed_shift).permit(:user_id, :start_time, :fixed_start_time, :fixed_end_time, :absence)
    end
    
    class SimpleCalendar::CurrentMonthCalendar < SimpleCalendar::MonthCalendar
      private
      
        def date_range
          beginning = start_date.beginning_of_month
          ending    = start_date.end_of_month
          (beginning..ending).to_a
        end
    end
end
