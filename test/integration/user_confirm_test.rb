require 'test_helper'
require 'database_cleaner'

class UserConfirmTest < Capybara::Rails::TestCase
  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  test "user confirms his token" do
    unconfirmed_user = FactoryGirl.create(:unconfirmed_user, :email=>"userconfirmshistoken@unfirmeduser.net")
    token = unconfirmed_user.confirmation_token

    visit "/confirm/#{token}"
    assert page.has_content? "Please save your password and user handle"
  end
  
  test "a user cannot edit another users profile" do
    the_admin = FactoryGirl.create(:admin_user)
    
    visit "/users/#{the_admin.id}/edit"
    assert page.has_content? "You don't have authorization for this resource"
    assert_equal "/", page.current_path

    
    password ="supersecretpassword"
    hashed_password = User.create_password(password)
    my_user = FactoryGirl.create(:user,:handle =>"RichardTheDog", :password => hashed_password)
    visit "/login"
    fill_in 'Email', with: my_user.email
    fill_in 'Password', with: password
    click_on 'Login'
    
    visit "/users/#{the_admin.id}/edit/"
    assert page.has_content? "You don't have authorization for this resource"
    assert_equal "/", page.current_path
    
    visit "/users/#{my_user.id}/edit"
    assert_not page.has_content? "You don't have authorization for this resource"
    assert_equal "/users/#{my_user.id}/edit", page.current_path
    
    
  end

end
