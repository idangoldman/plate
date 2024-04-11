class PagePresenter < Presenter::Base
  lexicon "page"

  vocabulary :date, :layout, :html, :permalink, :tags, :title

  grammar :date, format: "YYYY-MM-DD"
  grammar :html, escape: false, alias: :content
  grammar :tags, default: []
  grammar :title, titleize: true

  def current_page?( url )
    @permalink == url
  end

  def current_class( url, default_class = "current" )
    class_if( current_page?( url ), default_class )
  end
end
