class PagePresenter < PresenterBase
  def initialize
    super( i18n_base_path: "page" )
  end

  def template( basename, & )
    Utils.render_template( basename, self, & )
  end

  def class_if( condition, class_name )
    condition ? class_name : nil
  end

  def current_page?( url )
    t( "permalink" ) == url
  end

  def current_page_class( url, default_class = "current" )
    class_if( current_page?( url ), default_class )
  end
end
