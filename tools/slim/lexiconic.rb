module Lexiconic
  def self.included( base )
    base.extend( LexiconicMethods )
  end

  module LexiconicMethods
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
  end
end
