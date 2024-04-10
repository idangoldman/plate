# format escape, encode, parse, sanitize, normalize, serialize, validate
module Preparable
  def self.included( base )
    base.extend( PreparableMethods )
  end

  module PreparableMethods
    def properties( *args )
      # args.each do |property|
      #   define_method( property ) do
      #     instance_variable_get( :"@#{property}" )
      #   end
      # end
    end
    alias property properties

    def prepare( attribute, options = {} )
      define_method( attribute ) do
        value = instance_variable_get( :"@#{attribute}" )

        options.each do |option, setting|
          next if setting.false?

          next unless respond_to?( :"#{option}", true )

          value = if setting.is_a?( Boolean )
                    send( :"#{option}", value )
                  else
                    send( :"#{option}", value, setting )
                  end
        end

        value
      end
    end
  end

  private

  def format( value, format )
    value.strftime( format ) if value.respond_to?( :strftime )
  end

  def escape( value )
    CGI.escapeHTML( value.to_s )
  end

  def encode( value )
    URI.encode_www_form_component( value.to_s )
  end

  def decode( value )
    loop do
      previous_value = value
      value = URI.decode_www_form_component( value )
      break if value == previous_value
    end

    value
  end

  def titleize( value )
    if value.is_a?( String )
      value.split.map( &:capitalize ).join( " " )
    else
      value
    end
  end

  def shorten( value, length )
    value.to_s[0, length]
  end

  def json( value )
    # value.to_json
    JSON.parse( value )
  end

  def default( value, default = "" )
    value || default
  end

  def alias( value, alias_name )
    value = instance_variable_get( :"@#{value}" )
    instance_variable_set( :"@#{alias_name}", value )
  end
end
