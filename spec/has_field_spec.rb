require 'spec_helper'

describe "asserting on fields" do
  it "can tell if a field is present" do
    assert assert_has_field(Foobar, :fizzbuzz)
  end

  it "can check options on the field" do
    assert assert_has_field(Foobar, :fizzbuzz, :type => String)
    Foobar.must_have_field(:fizzbuzz)
  end

  it "raises MiniTest::Assertion on an option mismatch" do
    assert_triggers_failure do
      assert_has_field Foobar, :fizzbuzz, :type => Array
    end
  end

  it "raises a useful message" do
    assert_triggers_failure "Expected Foobar to have field :not_present." do
      assert_has_field Foobar, :not_present
    end
  end

  it "includes options in the message" do
    assert_triggers_failure "Expected Foobar to have field :fizzbuzz with options '{:type=>Array}'." do
      assert_has_field Foobar, :fizzbuzz, :type => Array
    end
  end

  it "can check with multiple options" do
    assert assert_has_field(Foobar, :fizzbuzz, :type => String, :default => "FIZZBUZZ")
    Foobar.must_have_field(:fizzbuzz, :type => String, :default => "FIZZBUZZ")
  end

  it "raises MiniTest::Assertion on a single option mismatch" do
    assert_triggers_failure do
      assert_has_field Foobar, :fizzbuzz, :type => String, :default => "BOGUS"
    end
  end

  it "can refute the presence of a field" do
    refute_has_field Foobar, :not_present
    Foobar.wont_have_field(:not_present)
  end

  it "will include a useful message for field refutation" do
    assert_triggers_failure "Expected Foobar not to have field :fizzbuzz." do
      refute_has_field Foobar, :fizzbuzz
    end
  end
end
