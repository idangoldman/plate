class BasePresenter
  def initialize( i18n_base_path: "" )
    @base_path = i18n_base_path
  end

  def t( key, options = {} )
    key = "#{@base_path}.#{key}" unless @base_path.empty?

    I18n.t( key, options )
  end

  def l( key, options = {} )
    return key unless localized?( key )

    I18n.l( key, options )
  end

  def localized?( value )
    case value
    when Date, DateTime, Time
      true
    when String
      !!DateTime.parse( value )
    when Integer
      !!Time.at( value )
    else
      raise ArgumentError, "Invalid value type"
    end
  rescue ArgumentError, TypeError
    false
  end

  def template( basename, & )
    Utils.render_template( basename, self, & )
  end

  def class_if( condition, class_name )
    condition ? class_name : nil
  end
end
