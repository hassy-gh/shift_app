require 'test_helper'

class HopeShiftsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @hope_shift = hope_shifts(:one)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_hope_shift_path(@hope_shift)
    # content/timeどちらも入力している場合
    patch hope_shift_path(@hope_shift), params: { hope_shift: { start_time: @hope_shift.start_time,
                                                                content: "F",
                                                                hope_start_time: "10:00",
                                                                hope_end_time: "17:00" } }
    assert_template 'hope_shifts/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # content/timeどちらも空の場合
    patch hope_shift_path(@hope_shift), params: { hope_shift: { start_time: @hope_shift.start_time,
                                                                content: "",
                                                                hope_start_time: "",
                                                                hope_end_time: "" } }
    assert_template 'hope_shifts/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_hope_shift_path(@hope_shift)
    patch hope_shift_path(@hope_shift), params: { hope_shift: { start_time: @hope_shift.start_time,
                                                                content: "F",
                                                                hope_start_time: "",
                                                                hope_end_time: "" } }
    assert_not flash.empty?
    assert_redirected_to hope_shifts_path
  end
end
