source 'https://rubygems.org'

gem 'spectator-validates_email', path: '..', require: 'validates_email'
gem 'activemodel', '~> 5.0.0'

group :test do
  gem 'rspec'
  gem 'sqlite3'
  gem 'rake'
end
