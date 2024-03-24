class TemplateHelpers
  attr_reader :locals, :render

  def initialize(locals, render)
    # OpenStruct.new.extend(TemplateHelpers)
    @locals = locals
    @render = render
  end

  def method_missing(method, *args, &block)
    @locals.send(method, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @locals.respond_to?(method_name)
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
