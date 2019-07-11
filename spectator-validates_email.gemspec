require File.expand_path("../lib/validates_email/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "spectator-validates_email"
  s.version     = ValidatesEmail::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Yury Velikanau"]
  s.date        = ["2010-10-24"]
  s.email       = ["yury.velikanau@gmail.com"]
  s.homepage    = "http://github.com/spectator/validates_email"
  s.summary     = "Rails plugin to validate email addresses"
  s.description = "Rails plugin to validate email addresses against RFC 2822 and RFC 3696"

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir["{lib}/**/*.rb", "MIT-LICENSE", "*.rdoc"]
  s.require_path = 'lib'

  s.add_dependency "activemodel", ">= 4.2.0"
end
