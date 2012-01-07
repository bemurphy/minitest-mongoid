module MiniTest
  module Assertions
    def assert_has_field(model_class, field_name, options = {}, msg = nil)
      msg = message(msg) {
        msg = "Expected #{model_class.name} to have field :#{field_name}"
        msg << " with options '#{options.inspect}'" unless options.empty?
        msg
      }
      field = model_class.fields[field_name.to_s]

      assert field, msg
      unless options.empty?
        assert options.all? { |k,v| field.send(k) == v }, msg
      end
      true
    end

    def refute_has_field(model_class, field_name, msg = nil)
      msg = message(msg) {
        "Expected #{model_class.name} not to have field :#{field_name}"
      }
      refute model_class.fields[field_name.to_s], msg
      true
    end
  end

  module Expectations
    infect_an_assertion :assert_has_field, :must_have_field, :reverse
    infect_an_assertion :refute_has_field, :wont_have_field, :reverse
  end
end
