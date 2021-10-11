class AddUserIdToFixedShifts < ActiveRecord::Migration[6.0]
  def change
    add_reference :fixed_shifts, :user,  null: false, foreign_key: true
  end
end
