require 'rubygems'
require 'wirble'
require 'g' rescue nil

# start wirble (with color)
Wirble.init # (:skip_prompt => true)
Wirble.colorize

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# vim:syntax=ruby:sw=2:sts=2
