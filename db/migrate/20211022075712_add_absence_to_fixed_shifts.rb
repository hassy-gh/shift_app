class AddAbsenceToFixedShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :fixed_shifts, :absence, :boolean, default: false, null: false
  end
end
