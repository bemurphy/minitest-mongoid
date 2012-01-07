gem "minitest"
require "minitest/spec"
require "minitest/autorun"

require "minitest-mongoid"

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("mintest_mongoid_specs")
end

# TODO bring this into relevant spec files
# so it's easier to read
class Foobar
  include Mongoid::Document

  field :fizzbuzz, :type => String, :default => "FIZZBUZZ"

  validates_format_of :fizzbuzz, :with => /[A-Za-z]/
  validates_length_of :fizzbuzz, :within  => 4..40

  embeds_many :things
  embedded_in :another_thing, :inverse_of => :word
  references_many :relations, :class_name => "Relation"

  key :fizzbuzz
end

module MiniTest
  module Assertions
    def assert_triggers_failure(expected = nil, klass = MiniTest::Assertion)
      e = assert_raises(klass) do
        yield
      end

      if expected
        msg = e.message.sub(/(---Backtrace---).*/m, '\1')
        msg.gsub!(/\(oid=[-0-9]+\)/, '(oid=N)')

        assert_equal expected, msg
      end

      true
    end
  end
end
