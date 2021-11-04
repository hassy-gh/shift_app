require 'test_helper'

class HopeShiftsNewTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @day = Date.today
  end
  
  test "unsuccessful new" do
    log_in_as(@user)
    get new_hope_shift_path(@day)
    # content/timeどちらも入力している場合
    post hope_shifts_path, params: { hope_shift: { content: "F",
                                                   hope_start_time: "10:00",
                                                   hope_end_time: "17:00" } }
    assert_template 'hope_shifts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # content/timeどちらも空の場合
    post hope_shifts_path, params: { hope_shift: { content: "",
                                                   hope_start_time: "",
                                                   hope_end_time: "" } }
    assert_template 'hope_shifts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "successful new" do
    log_in_as(@user)
    get new_hope_shift_path(@day)
    post hope_shifts_path, params: { hope_shift: { start_time: @day,
                                                   content: "",
                                                   hope_start_time: "10:00",
                                                   hope_end_time: "17:00" } }
    assert_not flash.empty?
    assert_redirected_to hope_shifts_path
  end
end
