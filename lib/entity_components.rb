module EntityComponents
  extend ActiveSupport::Concern

  included do
    serialize :components, Array
    serialize :values

    after_initialize :initialize_components
  end

  def initialize_components
    components.each do |c|
      variable_name = "@#{c}".to_sym
      klass = c.camelize.constantize
      values = attributes["values"]

      define_singleton_method c do
        instance_variable_get(variable_name) || instance_variable_set(variable_name, klass.new(values))
      end
    end
  end
end
