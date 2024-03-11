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

  # https://github.com/slim-template/slim/blob/main/doc/include.md
  # https://github.com/slim-template/slim/blob/main/lib/slim/include.rb
  # https://github.com/slim-template/slim/blob/main/lib/slim/interpolation.rb
  # def include_slim(name, options = {}, &block)
  #   Slim::Template.new("#{name}.slim", options).render(self, &block)
  # end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
