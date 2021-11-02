require 'test_helper'

class FixedShiftTest < ActiveSupport::TestCase
  
  def setup
    @fixed_shift = fixed_shifts(:one)
  end
  
  test "should be valid" do
    assert @fixed_shift.valid?
  end
  
  test "start_time should be present" do
    @fixed_shift.start_time = " "
    assert_not @fixed_shift.valid?
  end
  
  test "start_time should be unique (user)" do
    duplicate_fixed_shift = @fixed_shift.dup
    assert_not duplicate_fixed_shift.valid?
  end
  
  test "user_id should be present" do
    @fixed_shift.user_id = nil
    assert_not @fixed_shift.valid?
  end
  
  test "should require either absence or time (both nil)" do
    @fixed_shift.fixed_start_time = @fixed_shift.fixed_end_time = nil
    assert_not @fixed_shift.valid?
  end
  
  test "should require either absence or time (both present)" do
    @fixed_shift.absence = true
    assert_not @fixed_shift.valid?
  end
  
  test "fixed_start_time should be present" do
    @fixed_shift.fixed_start_time = nil
    assert_not @fixed_shift.valid?
  end
  
  test "fixed_end_time should be present" do
    @fixed_shift.fixed_end_time = nil
    assert_not @fixed_shift.valid?
  end
end
