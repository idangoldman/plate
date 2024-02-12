require "slim"
require "ostruct"
require "yaml"
require "i18n"

module SlimHelpers
  def self.render_partial(partial_name, locals = {})
    partial_path = "path/to/partials/_#{partial_name}.slim"
    self.render_template(partial_path, locals)
  end

  def self.render_template(template_path, locals = {})
    Slim::Template.new(template_path).render(OpenStruct.new locals)
  end

  def self.initialize_i18n
    I18n.load_path += Dir['../../locales/*.yml']
    I18n.default_locale = :en
  end

  def self.change_locale(lang_code = :en)
    I18n.locale = lang_code
  end

  def html_safe(string)
    string.respond_to?(:html_safe) ? string.html_safe : string
  end

  def link_to(name, url, options = {})
    "<a href=\"#{url}\" #{options.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')}>#{name}</a>"
  end

  def class_if(condition, class_name)
    condition ? class_name : nil
  end

  def image_tag(src, alt: "", **attrs)
    "<img src=\"#{asset_path(src)}\" alt=\"#{alt}\" #{attrs.map { |k, v| "#{k}='#{v}'" }.join(' ')}>"
  end

  def javascript_include_tag(src)
    "<script src=\"#{asset_path(src)}\"></script>"
  end

  def stylesheet_link_tag(src)
    "<link rel=\"stylesheet\" href=\"#{asset_path(src)}\">"
  end

  def asset_path(src)
    "/assets/#{src}" # Customize based on your asset directory structure
  end

end
