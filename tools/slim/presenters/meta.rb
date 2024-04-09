class MetaPresenter < BasePresenter
  attr_reader :date, :description, :json_ld, :robots, :tags, :title, :permalink

  i18n "page", "meta"

  # escape, encode, parse, sanitize, normalize, serialize, validate

  prepare :date, format: "YYYY-MM-DD"
  prepare :description, shorten: 160
  prepare :json_ld, parse: :json
  prepare :robots, default: "noindex, nofollow"
  prepare :tags, alias: :keywords, default: []
  prepare :title, shorten: 60
  prepare :permalink, encode: true

  def initialize
    super

    @definitions = {
      favicons: [16, 32, 96, 192, 512],
      json_ld: ["@context=http://schema.org", "@type=WebPage", "description", "image", "title"],
      links: ["canonical"],
      meta: %w[author charset copyright date description generator keywords lang publisher
               robots title],
      og: %w[description image site_name title type url locale],
      twitter: %w[creator description image player site title]
    }
  end
end
