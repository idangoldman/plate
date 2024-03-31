class PresenterBase
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
    return true if value.is_a?(Date) || value.is_a?(DateTime) || value.is_a?(Time)
    return true if value.is_a?(String) && formatted_date?(value)
    return true if value.is_a?(Integer) && timestamp?(value)
    false
  end

  def formatted_date?( value )
    DateTime.parse( value )
    true
  rescue ArgumentError
    false
  end

  def timestamp?( value )
    Time.at( value )
    true
  rescue TypeError, ArgumentError
    false
  end
end
