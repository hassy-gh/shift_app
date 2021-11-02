require 'test_helper'

class HopeShiftTest < ActiveSupport::TestCase
  
  def setup
    @hope_shift = hope_shifts(:one)
  end
  
  test "should be valid" do
    assert @hope_shift.valid?
  end
  
  test "start_time should be present" do
    @hope_shift.start_time = " "
    assert_not @hope_shift.valid?
  end
  
  test "start_time should be unique (user)" do
    duplicate_hope_shift = @hope_shift.dup
    assert_not duplicate_hope_shift.valid?
  end
  
  test "user_id should be present" do
    @hope_shift.user_id = nil
    assert_not @hope_shift.valid?
  end
  
  test "should require either content or time (both nil)" do
    @hope_shift.hope_start_time = @hope_shift.hope_end_time = nil
    assert_not @hope_shift.valid?
  end
  
  test "should require either content or time (both present)" do
    @hope_shift.content = "F"
    assert_not @hope_shift.valid?
  end
end
