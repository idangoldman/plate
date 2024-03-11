require "slim"
require "ostruct"
require "yaml"
require "i18n"

module SlimHelpers
  extend self

  def template(name, locals = {}, &block)
    render_template("#{$TEMPLATES_PATH}/#{name}", locals, &block)
  end

  def render_template(name, locals = {}, &block)
    scope = OpenStruct.new(locals)
    scope.extend(SlimHelpers)

    Slim::Template.new("#{name}.slim").render(scope, &block)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
