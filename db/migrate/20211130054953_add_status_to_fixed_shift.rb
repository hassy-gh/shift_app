class AddStatusToFixedShift < ActiveRecord::Migration[6.0]
  def change
    add_column :fixed_shifts, :status, :integer, default: 0, null: false
  end
end
