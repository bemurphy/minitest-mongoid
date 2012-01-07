require 'spec_helper'

describe "association assertions" do
  it "passes for an embeds_many" do
    assert assert_has_association(Foobar, :embeds_many, :things)
    Foobar.must_have_association(:embeds_many, :things)
  end

  it "passes when the association options are specified for an embedded_in" do
    assert assert_has_association(Foobar, :embedded_in, :another_thing, :inverse_of => :word)
  end

  it "raises MiniTest::Assertion when association options mismatch" do
    assert_triggers_failure do
      assert_has_association(Foobar, :embedded_in, :another_thing, :inverse_of => :bogus)
    end
  end

  it "returns useful messages" do
    assert_triggers_failure "Expected Foobar to have association 'embeds_many :not_present'." do
      assert_has_association(Foobar, :embeds_many, :not_present)
    end
  end

  it "includes options in the msg for failures" do
    assert_triggers_failure "Expected Foobar to have association 'embedded_in :another_thing' with options '{:inverse_of=>:bogus}'." do
      assert_has_association(Foobar, :embedded_in, :another_thing, :inverse_of => :bogus)
    end
  end

  it "passes when the association options are specified for a references_many" do
    assert assert_has_association(Foobar, :references_many, :relations, :class_name => "Relation")
  end
end

