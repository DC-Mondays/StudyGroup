require 'test_helper'

class UserTest < ActiveSupport::TestCase


  test "self.create_conformation_token should return a random 32 character code" do
    first_code = User.create_confirmation_token
    second_code = User.create_confirmation_token
    puts first_code
    puts "\n"
    puts second_code
    puts "\n"
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
 # test "test that invite returns user object" do
#    creator = FactoryGirl.build(:user)
#    @user = User.invite('example@email.com', creator)
#
#    assert @user, "invite should create user object"
#  end
  
end
