class MetaPresenter < Presenter::Base
  lexicons :page, :meta

  vocabulary :date, :description, :json_ld, :robots, :tags, :title, :permalink

  grammar :date, format: "YYYY-MM-DD"
  grammar :description, shorten: 160
  grammar :json_ld, parse: :json
  grammar :robots, default: "noindex, nofollow"
  grammar :tags, alias: :keywords, default: []
  grammar :title, shorten: 60
  grammar :permalink, encode: true
end
