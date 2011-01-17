require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec"
require "rspec/core/rake_task"

Rspec::Core::RakeTask.new(:spec)

namespace :ci do
  desc "Run CI tasks"
  task :run do
    Bundler.with_clean_env do
      sh "bundle install"
      sh "bundle exec rake spec"
    end
  end
end