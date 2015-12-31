require 'test_helper'

class AdminUserInviteTest < Capybara::Rails::TestCase #ActionDispatch::IntegrationTest
  test "admin logs in" do
    #https!

    admin = FactoryGirl.create(:admin_user)
    visit "/login"

    assert page.has_content?('Login')

    assert page.has_selector?('input#email')
    assert page.has_selector?('input#password')

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_on 'Login'


    assert_current_path '/page/user_home'
    
    assert page.has_content?("Welcome, #{admin.handle}"), "Should display username in welcome message"
  end
end
