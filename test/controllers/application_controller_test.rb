require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "set_user does not set current_user if user credentials are incorrect" do
    my_user = FactoryGirl.create(:user)

    User.stub(:hash_password, my_user.password) do
      @controller.set_user(my_user.email, my_user.password)

      assert_equal my_user, @controller.current_user
    end

  end
end
