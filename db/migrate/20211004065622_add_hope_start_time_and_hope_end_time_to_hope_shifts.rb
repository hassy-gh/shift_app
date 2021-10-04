class AddHopeStartTimeAndHopeEndTimeToHopeShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :hope_shifts, :hope_start_time, :time
    add_column :hope_shifts, :hope_end_time, :time
  end
end
