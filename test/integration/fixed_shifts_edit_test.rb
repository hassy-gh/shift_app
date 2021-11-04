require 'test_helper'

class FixedShiftsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @fixed_shift = fixed_shifts(:one)
  end
  
  test "unsuccessful edit" do
    log_in_as(@admin)
    get edit_fixed_shift_path(@fixed_shift)
    # absense/timeどちらも入力されている場合
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                                   user_id: @admin.id,
                                                                   absence: true,
                                                                   fixed_start_time: "10:00",
                                                                   fixed_end_time: "17:00" } }
    assert_template 'fixed_shifts/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # absense/timeどちらも空の場合
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                                   user_id: @admin.id,
                                                                   absence: false,
                                                                   fixed_start_time: "",
                                                                   fixed_end_time: "" } }
    assert_template 'fixed_shifts/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    # timeのどちらかが空の場合
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                                   user_id: @admin.id,
                                                                   absence: false,
                                                                   fixed_start_time: "10:00",
                                                                   fixed_end_time: "" } }
    assert_template 'fixed_shifts/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "successful edit" do
    log_in_as(@admin)
    get edit_fixed_shift_path(@fixed_shift)
    patch fixed_shift_path(@fixed_shift), params: { fixed_shift: { start_time: @fixed_shift.start_time,
                                                                   user_id: @admin.id,
                                                                   absence: false,
                                                                   fixed_start_time: "10:00",
                                                                   fixed_end_time: "22:00" } }
    assert_not flash.empty?
    assert_redirected_to day_index_fixed_shifts_path(@fixed_shift.start_time)
  end
end
