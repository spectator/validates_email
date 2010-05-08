require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_support/core_ext/logger'

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

  ActiveRecord::Base.establish_connection(config['plugin_test'])
  load(File.dirname(__FILE__) + "/schema.rb")
  require File.dirname(__FILE__) + '/../init.rb'
end
