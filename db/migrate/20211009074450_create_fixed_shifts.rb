class CreateFixedShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :fixed_shifts do |t|
      t.date :start_time
      t.time :fixed_start_time
      t.time :fixed_end_time

      t.timestamps
    end
  end
end
