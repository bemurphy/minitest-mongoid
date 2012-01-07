module MiniTest
  module Assertions
    def assert_has_association(model_class, type, field_name, options = {}, msg = nil)
      msg = message(msg) {
        msg = "Expected #{model_class.name} to have association '#{type} :#{field_name}'"
        msg << " with options '#{options.inspect}'" unless options.empty?
        msg
      }

      assoc = model_class.relations[field_name.to_s]
      assert (!assoc.nil? && assoc.macro == type.to_sym), msg

      unless options.empty?
        assert options.all? { |k, v| assoc.send(k) == v }, msg
      end

      true
    end
  end

  module Expectations
    infect_an_assertion :assert_has_association, :must_have_association, :reverse
  end
end
