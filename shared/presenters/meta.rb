class MetaPresenter < Presenter::Base
  lexicons "page", "meta"
  # context "page", "meta"

  properties :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # glossary :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # words :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # terms :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # vocabulary :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # vocab :date, :description, :json_ld, :robots, :tags, :title, :permalink
  # context :date, :description, :json_ld, :robots, :tags, :title, :permalink

  # grammar :date, format: "YYYY-MM-DD"
  prepare :date, format: "YYYY-MM-DD"
  prepare :description, shorten: 160
  prepare :json_ld, parse: :json
  prepare :robots, default: "noindex, nofollow"
  prepare :tags, alias: :keywords, default: []
  prepare :title, shorten: 60
  prepare :permalink, encode: true
end
