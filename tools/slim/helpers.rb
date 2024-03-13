require_relative "utils"

module SlimHelpers
  extend self

  def template(basename, locals = {}, &block)
    Utils.render_template("#{$TEMPLATES_PATH}/#{basename}", locals, &block)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ''
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
