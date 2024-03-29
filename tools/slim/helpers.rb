class Helpers
  def template(basename, &)
    Utils.render_template(basename, self, &)
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def current_link(name, url, options = {})
    class_name = options[:class] || ""
    "<a href='#{url}' class='#{class_name}'>#{name}</a>"
  end
end
