$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bundler/setup'
require 'how_many_days'

run HowManyDays
