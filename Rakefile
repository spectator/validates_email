require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "spectator-validates_email"
    gem.summary = %Q{Gem to validate email addresses for Rails 3}
    gem.description = %Q{validates_email is a Rails 3 plugin that validates email addresses against RFC 2822 and RFC 3696}
    gem.email = "yury.velikanau@gmail.com"
    gem.homepage = "http://github.com/spectator/validates_email"
    gem.authors = ["Yury Velikanau"]
    gem.add_development_dependency "activerecord", ">= 3.0.0.beta"
    gem.add_development_dependency "activesupport", ">= 3.0.0.beta"
    gem.add_development_dependency "sqlite3-ruby", ">= 1.3.1"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ValidatesEmail'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
