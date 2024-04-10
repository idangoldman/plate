class Locals
  attr_reader :head, :attributes_tree

  @@attributes_tree = {}

  def self.load( contents )
    loaded_yaml = Psych.safe_load( contents, permitted_classes: [Date, Time], symbolize_names: true )
    @@attributes_tree = deep_openstruct_from( loaded_yaml )
  end

  def initialize
    @head = @@attributes_tree.deep_dup
  end

  def method_missing( name, *args, & )
    missing_name = define_missing_name( name, args )
    attributes_from( missing_name ) || super
  end

  def respond_to_missing?( name, include_private = false )
    missing_name = define_missing_name( name, [] )
    @head.respond_to?( missing_name ) || super
  end

  private

  def head_reset_return
    value = @head.deep_dup
    @head = @@attributes_tree.deep_dup
    value
  end

  def define_missing_name( name, args )
    defined_name = if name.to_sym == :[]
                     args.first
                   else
                     name
                   end

    defined_name.to_s
  end

  def attributes_from( name )
    unless @head.respond_to?( name )
      head_reset_return
      return nil
    end

    @head = @head.dig( name )

    return head_reset_return unless [Hash, Array, OpenStruct].include?( @head.class )

    self
  end

  def self.deep_openstruct_from( object )
    case object
    when Hash
      object.each_with_object( OpenStruct.new ) do |( key, value ), result|
        result[key] = deep_openstruct_from( value )
      end
    when Array
      object.map { |element| deep_openstruct_from( element ) }
    else
      object
    end
  end
end
