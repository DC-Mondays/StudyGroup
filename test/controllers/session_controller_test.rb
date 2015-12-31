require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should create a session for the user with proper credentials" do
    user = FactoryGirl.create(:user)

    User.stub(:authenticate, user) do

      post :create, :email => user.email, :password => user.password
    end
    assert_equal "You have successfully logged in #{user.handle}", flash[:notice]

  end

  test "should NOT create a session for user improper credentials" do
  end

end
