class PagePresenter < BasePresenter
  attr_reader :date, :html, :permalink, :tags, :title

  i18n "page"

  prepare :date, format: "YYYY-MM-DD"
  prepare :html, escape: false, alias: :content
  prepare :permalink, encode: true
  prepare :tags, default: []
  prepare :title, titleize: true

  def current_page?( url )
    @permalink == url
  end

  def current_class( url, default_class = "current" )
    class_if( current_page?( url ), default_class )
  end
end
