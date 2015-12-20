require 'test_helper'
require 'mocha/expectation'
require 'minitest/mock'

class UserTest < ActiveSupport::TestCase


  test "self.create_conformation_token should return a random 32 character code" do
    first_code = User.create_confirmation_token
    second_code = User.create_confirmation_token

    assert_equal 32, first_code.length, "First code should be 32 char long"
    assert_equal 32, second_code.length, "Second code should be 32 char long"
    assert_not_equal first_code, second_code
  end

  test "self.create_invite_body should at least return a url with the confirmation code" do
    my_user = FactoryGirl.build(:user)
    User.stubs(:create_confirmation_token).returns("7e4fe0b6798e0a058f60782e3ace131e0f275ebc930a5cfae063ccb1782c1917")
    my_body = User.create_invite_body(my_user)

    assert my_body.include?(ENV["THIS_URL"] + "/users/confirm/" + "7e4fe0b6798e0a058f60782e3ace131e0f275ebc930a5cfae063ccb1782c1917"), "Must include host URL + confirmation path"
    User.unstub(:create_confirmation_token)
  end

  test "self.send_invite should send an invitation" do
    mock = Minitest::Mock.new
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin_user)

    mock.expect(:call, user, [String, String])
    InviteMailer.stub(:welcome_email, mock) do
      binding.pry
      outcome = User.send_invite(admin, user)
      assert_equal user, outcome
    end
    mock.verify
  end
end
