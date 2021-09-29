require 'test_helper'

class HopeShiftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get hope_shifts_new_url
    assert_response :success
  end

end
