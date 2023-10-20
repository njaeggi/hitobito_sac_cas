class ApplicationComponent < ViewComponent::Base

  def stimulus_controller
    cls = respond_to?(:component_class) ? component_class : self.class
    cls.name.underscore.gsub('/', '--').tr('_', '-')
  end

  def stimulus_action(action, event: nil)
    prefix = [event, stimulus_controller].compact.join('->')
    [prefix, action].join('#')
  end

  def stimulus_value(name, value)
    [[[stimulus_controller, name, 'value'].join('-'), value]].to_h
  end

  def stimulus_param(name, value)
    [[[stimulus_controller, name, 'param'].join('-'), value]].to_h
  end
end