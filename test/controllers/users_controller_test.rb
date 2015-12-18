require 'test_helper'


class UsersControllerTest < ActionController::TestCase

  test "unauthorized user cannot invite another user" do
    UsersController.any_instance.stubs(:current_user).returns(nil)
    post :create, "user" => {"email" => "test1@example.com"}

    assert_redirected_to root_path
  end
  
  test "authorized user can invite another user" do
    @user_factory = FactoryGirl.create(:admin_user)
  
    UsersController.any_instance.stubs(:current_user).returns(@user_factory)
    post :create, "user" => {"email" => "test2@example.com"}

    new_user = User.find_by_email("test2@example.com")
    assert_redirected_to user_path(new_user)
  end
end
