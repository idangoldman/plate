class Locals
  @@attributes = {}
  @missing_keys = []

  def self.setup(contents, locales_path)
    self.load_yaml(contents)
    self.load_locales(locales_path)
  end

  def method_missing(method, *args, &block)
    value_from(method.to_s)
  end

  private

  def value_from(key)
    $LOG.info("GET DATA: #{key}")

    if missing_keys(key)
      value = I18n.t(missing_keys, default: self.attribute_from(missing_keys))
    end

    # if value.nil?
    #   missing_keys(key)
    #   value = I18n.t(missing_keys, default: self.attribute_from(missing_keys))
    # end

    # TODO: only return self if value is a hash with child hashes?
    # if it's a hash return as OpenStruct?
    if value.is_a?(Hash) then self else value end
  end

  def missing_keys=(key)
    if [@missing_keys.first, @missing_keys.last].include?(key)
      @missing_keys = [key]
    else
      @missing_keys << key
    end
  end

  def missing_keys
    @missing_keys.compact.join(".")
  end

  def self.attribute_from(key)
    $LOG.info("GET DATA: #{key}")
    keys = key.split(".").map(&:to_sym)
    @@attributes.dig(*keys) || ""
  end

  def self.structure_attributes(sym)
    @@attributes = sym.slice(:html, :layout, :permalink)

    if sym.key?(:frontmatter)
      @@attributes.merge!(sym[:frontmatter])
    end
  end

  def self.load_yaml(contents = "")
    yaml_sym = Psych.safe_load(contents, permitted_classes: [Date, Time], symbolize_names: true)
    self.structure_attributes(yaml_sym)
  end

  def self.load_locales(path, locale = :en)
    I18n.load_path += Dir[path]
    I18n.default_locale = locale
  end
end
