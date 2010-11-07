require File.expand_path("../lib/validates_email/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "spectator-validates_email"
  s.version     = ValidatesEmail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Yury Velikanau"]
  s.date        = ["2010-10-24"]
  s.email       = ["yury.velikanau@gmail.com"]
  s.homepage    = "http://github.com/spectator/validates_email"
  s.summary     = "Rails 3 plugin to validate email addresses"
  s.description = "Rails 3 plugin to validate email addresses against RFC 2822 and RFC 3696"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "actionpack",  "~> 3.0.0"
  s.add_dependency "activemodel", "~> 3.0.0"

  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0.0"
  s.add_development_dependency "sqlite3-ruby", "~> 1.3.1"

  s.files        = Dir["{lib}/**/*.rb", "MIT-LICENSE", "*.rdoc"]
  s.require_path = 'lib'
end
