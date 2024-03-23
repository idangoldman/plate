class Locals
  @@data = {}
  @missing_keys = []

  def self.load_yaml(contents = "")
    yaml_sym = Psych.safe_load(contents, permitted_classes: [Date, Time], symbolize_names: true)
    @@data = default_data_structure(yaml_sym)
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
    if [@@missing_keys.first, @@missing_keys.last].include?(key)
      @@missing_keys = [key]
    else
      @@missing_keys << key
    end
  end

  def missing_keys
    @@missing_keys.compact.join(".")
  end

  def default_data_structure(sym)
    locals = {
      content: sym[:html] || "",
      layout: sym[:layout] || "default",
      permalink: sym[:permalink] || "",
      frontmatter: sym[:frontmatter] || {},
    }

    if sym.has_key?(:frontmatter)
      locals.merge!(sym[:frontmatter])
    end

    # JSON.parse(locals.to_json, object_class: OpenStruct)
    locals
  end

  def get_data_from(key)
    $LOG.info("GET DATA: #{key}")
    keys = key.split(".").map(&:to_sym)
    @@data.dig(*keys) || ""
  end
end
