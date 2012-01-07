module MiniTest
  module Assertions
    def assert_has_key(model_class, key, msg = nil)
      msg = message(msg) {
        "Expected #{model_class.name} to have key :#{key}"
      }
      assert model_class.primary_key.include?(key.to_sym), msg
      true
    end
  end

  module Expectations
    infect_an_assertion :assert_has_key, :must_have_key, :reverse
  end
end
