require 'test_helper'


class UsersControllerTest < ActionController::TestCase

  test "unauthorized user cannot invite another user" do

    post :create, "user" => {"email" => "test@example.com"}

    assert_redirected_to root_path
  end

end
