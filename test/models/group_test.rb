require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  
  def setup
    @group = groups(:superdry)
  end
  
  test "should be valid" do
    assert @group.valid?
  end
  
  test "name should be present" do
    @group.name = " "
    assert_not @group.valid?
  end
  
  test "name should not be too long" do
    @group.name = "a" * 31
    assert_not @group.valid?
  end
  
  test "name should be unique" do
    duplicate_group = @group.dup
    assert_not duplicate_group.valid?
  end
  
  test "password should be present (noblank)" do
    @group.password = @group.password_confirmation = " " * 6
    assert_not @group.valid?
  end
  
  test "password should have a minimum length" do
    @group.password = @group.password_confirmation = "a" * 5
    assert_not @group.valid?
  end
end
