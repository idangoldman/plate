class Locals
  @@attributes = {}
  @missing_keys = []

  def self.setup(contents, locales_path)
    self.load_yaml(contents)
    self.load_locales(locales_path)
  end

  def method_missing(method, *args, &block)
    self.get(method.to_s)
  end

  def get(key)
    $LOG.info("GET DATA: #{key}")

    if missing_keys(key)
      value = I18n.t(missing_keys, default: get_data_from(missing_keys))
    end

    # if value.nil?
    #   missing_keys(key)
    #   value = I18n.t(missing_keys, default: get_data_from(missing_keys))
    # end

    if value.is_a?(Hash) then Locals else value end
  end

  private

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

  def structure_attributes(sym)
    locals = {
      content: sym[:html] || "",
      frontmatter: sym[:frontmatter] || {},
      layout: sym[:layout] || "default",
      permalink: sym[:permalink] || ""
    }

    if sym.has_key?(:frontmatter)
      locals.merge!(sym[:frontmatter])
    end

    # JSON.parse(locals.to_json, object_class: OpenStruct)
    locals
  end

  def self.get_data_from(key)
    $LOG.info("GET DATA: #{key}")
    keys = key.split(".").map(&:to_sym)
    @@attributes.dig(*keys) || ""
  end

  def self.load_yaml(contents = "")
    yaml_sym = Psych.safe_load(contents, permitted_classes: [Date, Time], symbolize_names: true)
    @@attributes = structure_attributes(yaml_sym)
  end

  def self.load_locales(path, locale = :en)
    I18n.load_path += Dir[path]
    I18n.default_locale = locale
  end
end
