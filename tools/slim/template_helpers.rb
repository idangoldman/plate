class TemplateHelpers
  attr_reader :locals, :render

  def initialize(locals, render)
    @locals = locals
    @render = render
  end

  def method_missing(name, *args, &block)
    @locals.send(name, *args, &block) || super
  end

  def respond_to_missing?(name, include_private = false)
    @locals.respond_to?(name) || super
  end

  def template(basename, &block)
    @render.call(basename, self, &block)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
