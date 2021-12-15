class HopeShiftsController < ApplicationController
  before_action :logged_in_user
  before_action :no_join_user
  before_action :get_group, only: [:new, :create]
  before_action :get_hope_shift, only: [:edit, :update, :correct_user]
  before_action :correct_user, only: [:edit, :update]

  def index
    @hope_shifts = current_user.hope_shifts.all
    @hope_shift = current_user.hope_shifts.build
  end
  
  def new
    @day = params[:format]
    @hope_shift = current_user.hope_shifts.build
  end
  
  def create
    if params[:start_date].present? && [:end_date].blank?
      @hope_shift = current_user.hope_shifts.build(hope_shift_params)
      if @hope_shift.save
        flash[:success] = "登録しました"
        redirect_to hope_shifts_path
      else
        @day = params[:hope_shift][:start_time]
        render 'new'
      end
    elsif params[:start_date].present? && params[:end_date].present?
      dates = (params[:start_date].to_date)..(params[:end_date].to_date)
      dates.each do |date|
        @hope_shift = current_user.hope_shifts.build(start_date: date,
                                                     content: params[:content],
                                                     hope_start_time: params[:hope_start_time],
                                                     hope_end_time: params[:hope_end_time])
      end
      if @hope_shift.save
        flash[:success] = "登録しました"
        redirect_to hope_shifts_path
      else
        render 'index'
      end
    elsif params[:start_date].blank? && params[:end_date].present?
      flash[:danger] = "日付を選択してください"
      render 'index'
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
      params.require(:hope_shift).permit(:content, :start_time, :end_date, :hope_start_time, :hope_end_time)
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
