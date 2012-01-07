module MiniTest
  module Assertions
    def assert_has_validation(model_class, type, field_name, options = {}, msg = nil)
      msg = message(msg) {
        msg = "Expected #{model_class.name} to have validation '#{type} :#{field_name}'"
        msg << " with options '#{options.inspect}'" unless options.empty?
        msg
      }

      type = type.to_s.match(/validates_(.*)_of/)[1]
      validation = model_class._validators[field_name].detect { |v| v.class.name =~ /#{type.camelize}/ }
      assert validation, msg

      if validation.class.name =~ %r{Length} && options[:within]
        range = options[:within].to_a
        return assert(validation.options[:minimum] == range.first && validation.options[:maximum] == range.last), msg
      end

      unless options.empty?
        assert options.all? { |k,v| validation.options[k] == v }, msg
      end
      true
    end

  end

  module Expectations
    infect_an_assertion :assert_has_validation, :must_have_validation, :reverse
  end
end
