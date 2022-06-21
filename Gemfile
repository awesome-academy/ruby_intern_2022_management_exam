source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "activerecord-import"
gem "bcrypt"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "3.4.1"
gem "bullet", group: "development"
gem "cancancan", "~> 2.0"
gem "cocoon"
gem "config"
gem "devise", "~> 4.1"
gem "faker"
gem "font-awesome-rails"
gem "jbuilder", "~> 2.7"
gem "jquery-rails"
gem "mysql2", "~> 0.5.3"
gem "pagy"
gem "pry-rails"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.0"
gem "rails-i18n"
gem "ransack"
gem "sassc-rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner", "~> 1.5"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.0", require: false
  gem "simplecov"
  gem "simplecov-rcov"
  gem "webdrivers"
end

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
