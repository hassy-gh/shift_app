class FixedShiftsController < ApplicationController
  before_action :get_group, only: [:index, :new, :create, :edit, :update, :day_index]
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @fixed_shifts = @group.fixed_shifts.all
  end
  
  def new
    @day = params[:format]
    @hope_shifts = @group.hope_shifts.where(start_time: @day)
    @fixed_shift = FixedShift.new
    # @form = Form::FixedShiftCollection.new
  end
  
  def create
    @fixed_shift = FixedShift.find_or_initialize_by(start_time: params[:start_time], user_id: params[:user_id])
    if @fixed_shift.new_record?
      @fixed_shift = FixedShift.new(fixed_shift_params)
      if @fixed_shift.save
        flash[:success] = "登録しました"
        redirect_to fixed_shifts_path
      else
        @hope_shifts = @group.hope_shifts.where(start_time: params[:fixed_shift][:start_time])
        render 'new'
      end
    else
      if @fixed_shift.update!(fixed_shift_params)
        flash[:success] = "変更しました"
        redirect_to fixed_shifts_path
      else
        @hope_shifts = @group.hope_shifts.where(start_time: params[:fixed_shift][:start_time])
        render 'new'
      end
    end
  end
  
  def edit
    @fixed_shift = FixedShift.find(params[:id])
    @hope_shifts = @group.hope_shifts.where(start_time: @fixed_shift.start_time)
  end
  
  def update
    @fixed_shift = FixedShift.find(params[:id])
    if @fixed_shift.update(fixed_shift_params)
      flash[:success] = "変更しました"
      redirect_to fixed_shifts_path
    else
      @hope_shifts = @group.hope_shifts.where(start_time: params[:fixed_shift][:start_time])
      render 'edit'
    end
  end
  
  def destroy
  end
  
  def day_index
    @day = params[:format]
    @users = @group.users
    @fixed_shifts = @group.fixed_shifts.where(start_time: @day)
    @hope_shifts = @group.hope_shifts.where(start_time: @day)
  end
  
  private
  
    def fixed_shift_params
      params.require(:fixed_shift).permit(:user_id, :start_time, :fixed_start_time, :fixed_end_time)
    end
    
    # def fixed_shift_collection_params
    #   params
    #     .require(:form_fixed_shift_collection)
    #     .permit(fixed_shifts_attributes: [:user_id, :start_time, :fixed_start_time, :fixed_end_time])
    # end
end
