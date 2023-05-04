source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.3'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Specify version, per dependabot
gem 'activesupport', '>= 6.1.3.1'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"


# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# ===================== JSON Web Token (JWT) =======================
gem 'jwt'

# ================Environement Variables===================
gem 'dotenv', '~> 2.8', '>= 2.8.1'

# ======================== RACK GEMS =======================
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-attack'
gem "rack-cors"

# ======================== Background Jobs Gems ========================
gem 'sidekiq'
gem 'sidekiq-scheduler'

# ======================== JSON Serialization Gems ========================
gem 'blueprinter'
gem 'oj'
gem 'oj_mimic_json'

# ======================== Development Gems ========================
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"
end

