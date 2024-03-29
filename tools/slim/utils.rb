module Utils
  extend self

  def set_locales
    I18n.load_path = [
      Dir[$SLIM_PATHs[:locales]],
      Dir[$SLIM_PATHs[:contents]]
    ]

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

  def create_logger(log_file_path = 'slim.log')
    log_full_path = File.join($SLIM_PATHs[:logs], log_file_path)

    unless File.exist?(File.dirname(log_full_path))
      FileUtils.mkdir_p(File.dirname(log_full_path))
    end

    log = Logger.new(log_full_path)
    log.formatter = proc do |severity, datetime, progname, msg|
      "[#{datetime.strftime("%H:%M:%S")} #{severity}] #{msg}\n"
    end

    log
  end

  def compile_slim_to_html()
    # scope = TemplateHelpers.new(Locals, method(:render_template))
    # render_template(scope.locals[:layout], scope) { scope.locals[:content] }
  end

  def render_template(basename, scope, &block)
    template_file_path = "#{$SLIM_PATHs[:templates]}/#{basename}.slim"

    unless File.exist?(template_file_path)
      raise "'#{template_file_path}' template not found"
    end

    unless block_given?
      block = Proc.new {}
    end

    Slim::Template.new(template_file_path).render(scope, &block)
  end
end
