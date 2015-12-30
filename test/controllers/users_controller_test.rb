require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  # test "unauthorized user cannot invite another user" do
  #   UsersController.any_instance.stubs(:current_user).returns(nil)
  #   post :create, "user" => {"email" => "test1@example.com"}
  #
  #   assert_redirected_to root_path
  # end

  # test "authorized user can invite another user" do
  #   @user_factory = FactoryGirl.create(:admin_user)
  #
  #   UsersController.any_instance.stubs(:current_user).returns(@user_factory)
  #   post :create, "user" => {"email" => "test2@example.com"}
  #
  #   new_user = User.find_by_email("test2@example.com")
  #   assert_redirected_to user_path(new_user)
  # end

  test "confirm_user is called" do
    #unconfirmed_user = FactoryGirl.create(:unconfirmed_user)
    mock = Minitest::Mock.new
    mock.expect(:call, "User.confirm mock has been called", [String])
    User.stub(:confirm, mock) do
      post :confirm, :token => "potato"

      assert_silent do
        begin
          mock.verify
        rescue Exception => e
          puts "We found an error #{}"

        end
      end
    end


  end
end
