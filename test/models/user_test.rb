require 'test_helper'

class UserTest < ActiveSupport::TestCase


  test "self.create_conformation_token should return a random 32 character code" do
    first_code = User.create_confirmation_token
    second_code = User.create_confirmation_token

    assert_equal 32, first_code.length, "First code should be 32 char long"
    assert_equal 32, second_code.length, "Second code should be 32 char long"
    assert_not_equal first_code, second_code
  end

  #FIX call to MOCHA.stubs
  # test "self.create_invite_body should at least return a url with the confirmation code" do
 #    my_user = FactoryGirl.build(:user)
 #    User.stubs(:create_confirmation_token).returns("7e4fe0b6798e0a058f60782e3ace131e0f275ebc930a5cfae063ccb1782c1917")
 #    my_body = User.create_invite_body(my_user)
 #
 #    assert my_body.include?(ENV["THIS_URL"] + "/users/confirm/" + "7e4fe0b6798e0a058f60782e3ace131e0f275ebc930a5cfae063ccb1782c1917"), "Must include host URL + confirmation path"
 #    User.unstub(:create_confirmation_token)
 #  end


  test "self.send_invite should send an invitation" do
    mock = Minitest::Mock.new
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin_user)

    mock.expect(:call, user, [String, String])
    InviteMailer.stub(:welcome_email, mock) do
      outcome = User.send_invite(admin, user)
      assert_equal user, outcome
    end
    mock.verify
  end

  test "User.confirm takes a valid token and sets confirmed to be true and deletes token" do
    my_user = FactoryGirl.create(:unconfirmed_user, :email=>"unconfirmed_one@unconfirmed.net")
    token = my_user.confirmation_token || raise(Exception, "token should not be nil in test setup")
    assert_equal false, my_user.confirmed?

    User.confirm(token)
    my_user.reload
    assert_equal true, my_user.confirmed?
    assert_equal nil, my_user.confirmation_token
  end

  test "User.confirm returns nil when token is invalid" do
    my_user = FactoryGirl.create(:unconfirmed_user, :email => "unconfirmed_two@shouldbefalse.net")
    token = my_user.confirmation_token || raise(Exception, "token should not be nil in test setup")
    assert_equal nil, User.confirm("blip blip blue")
  end

  test "User.authenticate returns user when user credentials are correct" do
    my_user = FactoryGirl.create(:user)
    User.stub(:hash_password, my_user.password) do
      assert_equal my_user, User.authenticate(my_user.email, my_user.password)
    end
  end

  test "User.authenticate returns false when user credentials are incorrect" do
    my_user = FactoryGirl.create(:user)
    User.stub(:hash_password, "a different password") do
      assert_equal nil, User.authenticate(my_user.email, "wrongpassword")
    end
  end

end
