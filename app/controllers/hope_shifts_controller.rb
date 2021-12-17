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
    if params[:hope_shift][:start_time].present? && (params[:hope_shift][:start_date].nil? && params[:hope_shift][:end_date].nil?)
      @hope_shift = current_user.hope_shifts.build(hope_shift_params)
      if @hope_shift.save
        flash[:success] = "登録しました"
        redirect_to hope_shifts_path
      else
        @day = params[:hope_shift][:start_time]
        render 'new'
      end
    elsif params[:hope_shift][:start_time].nil? && (params[:hope_shift][:start_date].present? && params[:hope_shift][:end_date].present?)
      dates = (params[:hope_shift][:start_date].to_date)..(params[:hope_shift][:end_date].to_date)
      before_count = current_user.hope_shifts.count
      start_time = hope_start_time_join
      end_time = hope_end_time_join
      dates.each do |date|
        @hope_shift = current_user.hope_shifts.build(start_time: date.strftime("%Y-%m-%d"),
                                                     content: params[:hope_shift][:content],
                                                     hope_start_time: start_time,
                                                     hope_end_time: end_time)
        unless @hope_shift.save
          @hope_shifts = current_user.hope_shifts.all
          flash.now[:danger] = "正しく入力されていません。"
          render 'index'
          break
        end
      end
      if before_count < current_user.hope_shifts.count
        flash[:success] = "登録しました"
        redirect_to hope_shifts_path
      end
    elsif params[:hope_shift][:start_time].nil? && (params[:hope_shift][:start_date].blank? || params[:hope_shift][:end_date].blank?)
      @hope_shifts = current_user.hope_shifts.all
      @hope_shift = current_user.hope_shifts.build
      flash.now[:danger] = "日付を選択してください。"
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
      params.require(:hope_shift).permit(:content, :start_time, :start_date, :end_date, :hope_start_time, :hope_end_time)
    end
    
    def hope_start_time_join
      time1 = params[:hope_shift][:"hope_start_time(4i)"]
      time2 = params[:hope_shift][:"hope_start_time(5i)"]
      if time1.empty? && time2.empty?
        return
      elsif time1.present? && time2.present?
        return "#{time1}:#{time2}"
      elsif time1.present? && time2.empty?
        return "#{time1}:00"
      elsif time1.empty? && time2.present?
        return 
      end
    end
    
    def hope_end_time_join
      time1 = params[:hope_shift][:"hope_end_time(4i)"]
      time2 = params[:hope_shift][:"hope_end_time(5i)"]
      if time1.empty? && time2.empty?
        return
      elsif time1.present? && time2.present?
        return "#{time1}:#{time2}"
      elsif time1.present? && time2.empty?
        return "#{time1}:00"
      elsif time1.empty? && time2.present?
        return 
      end
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
