Capybara.javascript_driver = :webkit # Selenium works, but not as well

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  # Use transactions by default
  config.before :each do
    DatabaseCleaner.strategy = :truncation
  end

  # Switch to truncation for javascript tests, but *only clean used tables*
  config.before :each, :js => true do
    DatabaseCleaner.strategy = :truncation, {:pre_count => true}
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
