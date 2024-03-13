require "date"
require "i18n"
require "ostruct"
require "psych"
require "slim"
require "time"

require_relative "helpers"

module Utils
  extend self

  def load_locales
    I18n.load_path += Dir[$LOCALES_PATH]
    I18n.default_locale = :en
  end

  def set_slim
    Slim::Engine.set_options(
      enable_engines: [:ruby, :javascript, :css],
      pretty: true,
      streaming: true,
      tabsize: 2,
    )
  end

  def parse_yaml(contents = "")
    Psych.safe_load(contents, permitted_classes: [Date, Time], symbolize_names: true)
  end

  def compile_slim_to_html(contents)
    data = parse_yaml(contents)
    compiled_html = render_template(data[:layout], data) { data[:html] }
  end

  def render_template(basename, locals = {}, &block)
    scope = OpenStruct.new(locals)
    scope.extend(SlimHelpers)

    unless block_given?
      block = Proc.new {}
    end

    Dir.chdir($TEMPLATES_PATH) do
      Slim::Template.new("#{basename}.slim").render(scope, &block)
    end
  end
end
