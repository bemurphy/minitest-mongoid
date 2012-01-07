require 'spec_helper'

describe "asserting on validations" do
  it "can tell if a validation is present" do
    assert_has_validation Foobar, :validates_format_of, :fizzbuzz
    Foobar.must_have_validation(:validates_format_of, :fizzbuzz)
  end

  it "raises MiniTest::Assertion if a validation is not present" do
    assert_triggers_failure do
      assert_has_validation Foobar, :validates_uniqueness_of, :fizzbuzz
    end
  end

  it "includes a useful failure message" do
    assert_triggers_failure "Expected Foobar to have validation 'uniqueness :fizzbuzz'." do
      assert_has_validation Foobar, :validates_uniqueness_of, :fizzbuzz
    end
  end

  it "includes options in failure messages" do
    assert_triggers_failure "Expected Foobar to have validation 'format :fizzbuzz' with options '{:format=>/bogus/}'." do
      assert_has_validation Foobar, :validates_format_of, :fizzbuzz, :format => /bogus/
    end
  end

  it "can check the options for the validation" do
    assert assert_has_validation(Foobar, :validates_format_of, :fizzbuzz, :with => /[A-Za-z]/)
    Foobar.must_have_validation(:validates_format_of, :fizzbuzz, :with => /[A-Za-z]/)
  end

  it "raises MiniTest::Assertion on an option mismatch" do
    assert_triggers_failure do
      assert_has_validation Foobar, :validates_format_of, :fizzbuzz, :with => /[0-9]/
    end
  end

  it "passes when the validation options is specified using within" do
    assert assert_has_validation(Foobar, :validates_length_of, :fizzbuzz, :within => 4..40)
    Foobar.must_have_validation(:validates_length_of, :fizzbuzz, :within => 4..40)
  end
end
