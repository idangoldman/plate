class MetaPresenter < PresenterBase
  attr_reader :meta_data

  def initialize(page)
    @page = page
    @definitions = {
      favicons: [16, 32, 96, 192, 512],
      json_ld: ["@context=http://schema.org", "@type=WebPage", "description", "image", "title"],
      links: ["canonical"],
      meta: ["author", "charset", "copyright", "date", "description", "generator", "keywords", "lang", "publisher", "robots", "title"],
      og: ["description", "image", "site_name", "title", "type", "url", "locale"],
      twitter: ["creator", "description", "image", "player", "site", "title"],
    }

    generate_meta_data
  end

  def keywords
    keywords_array = fetch_meta_data(:keywords, default: [])
    join_and_truncate_keywords(keywords_array, 150)
  end

  def robots
    fetch_meta_data(:robots, default: "noindex, nofollow")
  end

  def json_ld
    fetch_meta_data(:json_ld, default: "").to_json
  end

  def title
    truncate_string(fetch_meta_data(:title), 60)
  end

  def description
    truncate_string(fetch_meta_data(:description), 160)
  end

  def method_missing(method_name, *args, &block)
    if @meta_data.key?(method_name.to_sym)
      @meta_data[method_name.to_sym]
    elsif @page.respond_to?(method_name)
      @page.public_send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @meta_data.key?(method_name.to_sym) || @page.respond_to?(method_name, include_private) || super
  end

  private

  def generate_meta_data
    @meta_data = @definitions.each_with_object({}) do |(key, items), result|
      result[key] = items.each_with_object({}) do |item, acc|
        value = process_item(item)
        acc.merge!(value) unless value.values.first.blank?
      end
    end
  end

  def process_item(item)
    if item.include?("@")
      key, default = item.split('=', 2)
      { key.to_sym => sanitize_value(default) }
    else
      { item.to_sym => sanitize_value(t(item)) }
    end
  end

  def sanitize_value(value)
    CGI.escapeHTML(value)
  end

  def date
    raw_date = fetch_meta_data(:date)
    raw_date.present? ? raw_date.to_date.to_formatted_s(:iso8601) : ""
  end

  def fetch_meta_data(key, default: "")
    value = if @page.respond_to?(key)
              @page.public_send(key)
            elsif @meta_data.key?(key)
              @meta_data[key]
            else
              default
            end
    sanitize_value(value)
  end

  def join_and_truncate_keywords(keywords, max_length)
    return "" if keywords.empty?
    truncated_keywords = keywords.join(", ")
    while truncated_keywords.length > max_length && keywords.any?
      keywords.pop
      truncated_keywords = keywords.join(", ")
    end
    truncated_keywords
  end

  def truncate_string(string, max_length)
    string.length > max_length ? "#{string[0...max_length-3]}..." : string
  end
end
