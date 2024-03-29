module Utils
  def self.set_locales
    I18n.load_path = [
      Dir[SLIM_PATHs[:locales]],
      Dir[SLIM_PATHs[:contents]]
    ]

    I18n.default_locale = :en
  end

  def self.set_slim
    Slim::Engine.set_options(
      enable_engines: %i[ruby javascript css],
      # logic_less: true,
      pretty: true,
      streaming: true,
      tabsize: 2
    )
  end

  def self.create_logger( log_file_path = "slim.log" )
    log_full_path = File.join( SLIM_PATHs[:logs], log_file_path )
    FileUtils.mkdir_p( File.dirname( log_full_path ) )

    log = Logger.new( log_full_path )
    log.formatter = proc do |severity, datetime, _progname, msg|
      "[#{datetime.strftime( '%H:%M:%S' )} #{severity}] #{msg}\n"
    end

    log
  end

  def self.compile_slim_to_html
    render_template( I18n.t( "page.layout" ), PagePresenter.new ) { I18n.t( "page.html" ) }
  end

  def self.render_template( basename, scope, &block )
    template_file_path = "#{SLIM_PATHs[:templates]}/#{basename}.slim"

    raise "'#{template_file_path}' template not found" unless File.exist?( template_file_path )

    block = proc {} unless block_given?

    Slim::Template.new( template_file_path ).render( scope, &block )
  end
end
