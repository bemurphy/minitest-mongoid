require 'spec_helper'

describe "has key assertions" do
  it "passes when the key is specified" do
    assert assert_has_key(Foobar, :fizzbuzz)
    Foobar.must_have_key(:fizzbuzz)
  end

  it "fails when the key doesn't match" do 
    assert_triggers_failure do
      assert_has_key(Foobar, :bogus)
    end
  end

  it "includes a helpful failure message" do 
    assert_triggers_failure "Expected Foobar to have key :bogus." do
      assert_has_key(Foobar, :bogus)
    end
  end
end
