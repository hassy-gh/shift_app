class ChangeDataStartTimeToHopeShifts < ActiveRecord::Migration[6.0]
  def change
    change_column :hope_shifts, :start_time, :date
  end
end
