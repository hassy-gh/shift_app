require 'test_helper'

class FixedShiftsDestroyTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @fixed_shift = fixed_shifts(:one)
    @group = groups(:superdry)
  end
  
  test "successful destroy" do
    log_in_as(@admin)
    get day_index_fixed_shifts_path(@fixed_shift.start_time)
    assert_select "a[href=?]", fixed_shift_path(@fixed_shift), count: 1
    assert_difference '@group.fixed_shifts.count', -1 do
      delete fixed_shift_path(@fixed_shift)
    end
    assert_not flash.empty?
    assert_redirected_to day_index_fixed_shifts_path(@fixed_shift.start_time)
  end
end
