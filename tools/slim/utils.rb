module Utils
  extend self

  def set_slim
    Slim::Engine.set_options(
      enable_engines: [:ruby, :javascript, :css],
      pretty: true,
      streaming: true,
      tabsize: 2,
    )
  end

  def create_logger(log_file_path = '/tmp/slim.log')
    unless File.exist?(File.dirname(log_file))
      FileUtils.mkdir_p(File.dirname(log_file))
    end

    log = Logger.new(log_file)
    log.formatter = proc do |severity, datetime, progname, msg|
      "[#{severity} #{datetime.strftime("%H:%M:%S")}] #{msg}\n"
    end

    log
  end

  def compile_slim_to_html()
    scope = TemplateHelpers.new(Locals.new, self.render_template)
    render_template(scope.locals[:layout], scope) { scope.locals[:content] }
  end

  def render_template(basename, scope, &block)
    template_file_path = "#{$SLIM_PATHs[:templates]}/#{basename}.slim"

    unless File.exist?(template_file_path)
      raise "Slim template not found: #{template_file_path}"
    end

    unless block_given?
      block = Proc.new {}
    end

    Slim::Template.new("#{template_file_path").render(scope, &block)
  end
end
