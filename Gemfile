source 'https://rubygems.org'

git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
    "https://github.com/#{repo_name}.git"
end

ruby "2.4.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'acts_as_votable'

group :development, :test do
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
    gem 'byebug', platform: :mri
end

group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'listen', '~> 3.0.5'
    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Paperclip (Image Uploading)
gem 'paperclip', "~> 5.0.0"
gem 'aws-sdk', "~> 2.3"

group :test do
    # Thin Server on Local Machine
    gem 'rspec-rails', '~> 3.5'
    gem 'factory_bot_rails', '~> 4.0'
    gem 'faker'
    gem 'database_cleaner'
    gem 'shoulda-matchers'
end

# Database Views

gem 'scenic'

gem 'devise'

# Devise Token Auth
gem 'devise_token_auth'

# Omniauth
gem 'omniauth'

# CORS

gem 'rack-cors', require: 'rack/cors'
