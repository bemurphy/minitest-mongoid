gem 'minitest'
require 'minitest/spec'
require 'mongoid'

Dir[File.dirname(__FILE__) + '/minitest-mongoid/*.rb'].each {|file| require file }
