require 'test_helper'

class GroupsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @group = groups(:superdry)
  end
  
  test "unsuccessful edit" do
    log_in_as(@admin)
    get edit_group_path(@group)
    assert_template 'groups/edit'
    patch group_path(@group), params: { group: { 
                                        name: "",
                                        password: "",
                                        password_confirmation: "" } }
    assert_template 'groups/edit'
  end
  
  test "successful edit" do
    log_in_as(@admin)
    get edit_group_path(@group)
    assert_template 'groups/edit'
    patch group_path(@group), params: { group: { 
                                        name: "new name",
                                        password: "",
                                        password_confirmation: "" } }
    assert_redirected_to edit_group_path(@group)
  end
end
