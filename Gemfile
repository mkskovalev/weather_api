source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'grape'
gem 'grape-swagger'
gem 'delayed_job_active_record'
gem 'rufus-scheduler'
gem 'redis'
gem 'daemons'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails'
end

group :test do
  gem 'vcr'
  gem 'webmock'
end
