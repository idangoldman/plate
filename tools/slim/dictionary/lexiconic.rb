require "i18n"

module Lexiconic
  def self.setup( locale: :en, load_path: [] )
    I18n.load_path += load_path
    I18n.default_locale = locale
    I18n.backend.load_translations
  end

  def self.included( base )
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    alias lexicons lexicon

    def lexicon( *paths )
      @lexicon_paths = paths.map( &:to_s )
    end

    def t( key, options = {} )
      key_path = find_key_path( key.to_s )
      I18n.t( key_path, **options )
    end

    def l( value, options = {} )
      return value unless localizable?( value )

      I18n.l( value, **options )
    end

    def localizable?( value )
      case value
      when Date, DateTime, Time then true
      when String then !!DateTime.parse( value )
      when Integer then !!Time.at( value )
      else false end
    rescue StandardError
      false
    end

    private

    def find_key_path( key )
      path = @lexicon_paths&.find { |prefix| I18n.exists?( "#{prefix}.#{key}" ) }
      path ? "#{path}.#{key}" : key
    end
  end
end
