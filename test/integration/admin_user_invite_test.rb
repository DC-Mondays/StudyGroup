require 'test_helper'
require 'database_cleaner'

class AdminUserInviteTest < Capybara::Rails::TestCase
  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
  test "admin logs in" do
    #https!

    admin = FactoryGirl.create(:admin_user)
    password = "my secret password"

    visit "/login"

    assert page.has_content?('Login')

    assert page.has_selector?('input#email')
    assert page.has_selector?('input#password')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: password

    click_on 'Login'

    assert_current_path '/page/user_home'

    assert page.has_content?("Welcome, #{admin.handle}"), "Should display username in welcome message"

  end

  test "admin can invite user" do
    admin = FactoryGirl.create(:admin_user)
    password = "my secret password"

    visit "/login"

    assert page.has_content?('Login')

    assert page.has_selector?('input#email')
    assert page.has_selector?('input#password')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: password

    click_on 'Login'

    assert page.has_selector?('ul#admin_options', "Admin should have admin menu")
    #binding.pry
    assert( page.has_content?('Invite User'), "Admin should see an invite link")

    click_on "Invite User"

    fill_in 'Email', with: 'lesliephifer@gmail.com'
    click_on 'Send Invite'

    assert(page.has_content?('Invite sent.'), "Message should be sent when invitation successful")
  end
end
