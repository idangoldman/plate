class MetaPresenter < Presenter::Base
  lexicons "page", "meta"

  properties :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # glossary :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # words :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # terms :date, :description, :json_ld, :robots, :tags, :title, :permalink

  prepare :date, format: "YYYY-MM-DD"
  prepare :description, shorten: 160
  prepare :json_ld, parse: :json
  prepare :robots, default: "noindex, nofollow"
  prepare :tags, alias: :keywords, default: []
  prepare :title, shorten: 60
  prepare :permalink, encode: true
end
