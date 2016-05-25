source 'https://rubygems.org'
ruby "2.1.7"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.0'

group :production do
  # postgre database
  gem 'pg'
end

group :development, :production do
  gem 'yaml_db'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # A library for setting up Ruby objects as test data.
  gem "factory_girl_rails", "~> 4.0"

  # Use rspec-rails
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'

  gem 'pry-byebug'

  # Use Capistrano for deployment
  gem 'capistrano', '3.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rails', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use debugger
  gem 'pry-rails'
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'meta_request' # work with RailsPanel https://chrome.google.com/webstore/detail/railspanel/gjpfobpafnhjhbajcjgccbbdofdckggg

  gem 'mailcatcher'
end


# ##################
# all environments
# #################
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

# Use unicorn as the app server
gem 'unicorn'
gem 'unicorn-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# from rails assets
gem 'bundler', '>= 1.8.4'
source 'https://rails-assets.org' do
  gem 'rails-assets-bsie'
end

gem 'haml-rails'
gem 'jquery-rails'

gem 'angularjs-rails'
gem 'angular-rails-templates'

gem "twitter-bootstrap-rails"

gem 'figaro'

# authorization
gem 'devise'
gem 'cancancan', '~> 1.10'

# markdown
gem 'bluecloth'

# image uploading
gem "paperclip", "~> 4.2"

gem 'tinymce-rails'

# exception_notification
gem 'exception_notification'
gem 'slack-notifier'

# pay
gem 'alipay', '~> 0.8.0'

# xml
gem 'nokogiri'
