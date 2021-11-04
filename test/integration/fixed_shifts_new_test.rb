require 'test_helper'

class FixedShiftsNewTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @day = Date.today
  end
  
  test "unsuccessful new" do
    log_in_as(@admin)
    get new_fixed_shift_path(format: @day, id: @non_admin.id)
    # absense/timeどちらも入力されている場合
    post fixed_shifts_path, params: { fixed_shift: { start_time: @day,
                                                     user_id: @non_admin.id,
                                                     absence: true,
                                                     fixed_start_time: "10:00",
                                                     fixed_end_time: "17:00" } }
    assert_template 'fixed_shifts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # absense/timeどちらも空の場合
    post fixed_shifts_path, params: { fixed_shift: { start_time: @day,
                                                     user_id: @non_admin.id,
                                                     absence: false,
                                                     fixed_start_time: "",
                                                     fixed_end_time: "" } }
    assert_template 'fixed_shifts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # timeのどちらかが空の場合
    post fixed_shifts_path, params: { fixed_shift: { start_time: @day,
                                                     user_id: @non_admin.id,
                                                     absence: false,
                                                     fixed_start_time: "10:00",
                                                     fixed_end_time: "" } }
    assert_template 'fixed_shifts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "successful new" do
    log_in_as(@admin)
    get new_fixed_shift_path(format: @day, id: @non_admin.id)
    post fixed_shifts_path, params: { fixed_shift: { start_time: @day,
                                                     user_id: @non_admin.id,
                                                     absence: true,
                                                     fixed_start_time: "",
                                                     fixed_end_time: "" } }
    assert_not flash.empty?
    assert_redirected_to day_index_fixed_shifts_path(@day)
  end
end
