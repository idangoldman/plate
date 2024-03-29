class TemplateHelpers
  attr_reader :render

  def initialize(render)
    @render = render
  end

  def template(basename, &)
    @render.call(basename, self, &)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ""
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
