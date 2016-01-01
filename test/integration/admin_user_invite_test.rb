require 'test_helper'
require 'database_cleaner'



class AdminUserInviteTest < Capybara::Rails::TestCase #ActionDispatch::IntegrationTest
  DatabaseCleaner.strategy = :truncation
  test "admin logs in" do
    #https!
    DatabaseCleaner.start
    admin = FactoryGirl.create(:admin_user, password: "my secret password")
    binding.pry
    
    visit "/login"

    assert page.has_content?('Login')

    assert page.has_selector?('input#email')
    assert page.has_selector?('input#password')
    User.stub(:hash_password, "my secret password") do
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password

      click_on 'Login'
    end
    
    assert_current_path '/page/user_home'
    
    assert page.has_content?("Welcome, #{admin.handle}"), "Should display username in welcome message"

  end
end
