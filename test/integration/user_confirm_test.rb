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
    unconfirmed_user = FactoryGirl.create(:unconfirmed_user)
    token = unconfirmed_user.confirmation_token

    visit "/confirm/#{token}"

    assert page.has_content? "Please save your password and user handle"
  end

end
