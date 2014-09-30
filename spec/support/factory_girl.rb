# spec/support/factory_girl.rb
RSpec.configure do |config|
  # additional factory_girl configuration

  config.before(:suite) do
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end
