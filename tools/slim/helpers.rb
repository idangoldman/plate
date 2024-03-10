require "slim"
require "ostruct"
require "yaml"
require "i18n"

module SlimHelpers
  extend self

  def render_template(contents_or_path, locals = {})
    scope = OpenStruct.new(locals)
    scope.extend(SlimHelpers)

    Slim::Template.new(contents_or_path).render(scope)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def javascript_include_tag(src)
    "<script src=\"#{asset_path(src)}\"></script>"
  end

  def stylesheet_link_tag(src)
    "<link rel=\"stylesheet\" href=\"#{asset_path(src)}\">"
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
