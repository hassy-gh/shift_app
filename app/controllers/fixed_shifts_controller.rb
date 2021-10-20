class FixedShiftsController < ApplicationController
  before_action :get_group, only: [:index, :new, :create, :edit, :update]
  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]
  
  def index
    @fixed_shifts = @group.fixed_shifts.all
  end
  
  def new
    @day = params[:format]
    @hope_shifts = @group.hope_shifts.where(start_time: @day)
    # count = Group.find(current_user.group_id).users.count
    # count.times do
      # @fixed_shift = FixedShift.new
      @form = Form::FixedShiftCollection.new
    # end
  end
  
  def create
    # @fixed_shift = FixedShift.new(fixed_shift_params)
    @form = Form::FixedShiftCollection.new(fixed_shift_collection_params)
    if @form.save
    # if @fixed_shift.save
      flash[:success] = "登録しました"
      redirect_to fixed_shifts_path
    else
      @hope_shifts = @group.hope_shifts.where(start_time: 
              params[:form_fixed_shift_collection][:fixed_shifts_attributes]["0"][:start_time])
      render 'new'
    end
  end
  
  def edit
    @fixed_shift = FixedShift.find(params[:id])
    @hope_shifts = @group.hope_shifts..where(start_time: @fixed_shift.start_time)
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
    @fixed_shifts = FixedShift.where(start_time: @day)
  end
  
  private
  
    # def fixed_shift_params
    #   params.require(:fixed_shift).permit(:user_id, :start_time, :fixed_start_time, :fixed_end_time)
    # end
    
    def fixed_shift_collection_params
      params
        .require(:form_fixed_shift_collection)
        .permit(fixed_shifts_attributes: [:user_id, :start_time, :fixed_start_time, :fixed_end_time])
    end
end
