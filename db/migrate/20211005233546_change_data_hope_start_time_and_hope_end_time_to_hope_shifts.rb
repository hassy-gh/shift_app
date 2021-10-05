class ChangeDataHopeStartTimeAndHopeEndTimeToHopeShifts < ActiveRecord::Migration[6.0]
  def change
    change_column :hope_shifts, :hope_start_time, :string
    change_column :hope_shifts, :hope_end_time, :string
  end
end
