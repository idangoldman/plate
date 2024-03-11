require "slim"
require "ostruct"
require "yaml"
require "i18n"

module SlimHelpers
  extend self

  def render_template(path, locals = {})
    scope = OpenStruct.new(locals)
    scope.extend(SlimHelpers)

    Slim::Template.new("#{PLATE_ROOT}/#{PLATE_ENV.templates.views}/#{path}.slim").render(scope)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
